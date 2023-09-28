import { Request, Response, NextFunction } from 'express';
import { ErrorHandler } from '../helpers/errorHandler';
import { updateMaterial, updateEduMaterialVersionURN } from '../queries/apiQueries';
import { updateEsDocument } from '../elasticSearch/es';
import { getEduMaterialVersionURL } from '../services/urlService';
import { pidResolutionService } from '../services';
import { winstonLogger } from '../util/winstonLogger';

export interface EducationalMaterialMetadata {
  name: {
    fi: string;
    sv: string;
    en: string;
  };
  keywords: Array<{
    key: string;
    value: string;
  }>;
  authors: Array<{
    organization: AuthorsOrganization;
    author: string;
  }>;
  learningResourceTypes: Array<{
    key: string;
    value: string;
  }>;
  educationalRoles: Array<{
    key: string;
    value: string;
  }>;
  educationalUses: Array<{
    key: string;
    value: string;
  }>;
  description: {
    fi: string;
    sv: string;
    en: string;
  };
  educationalLevels: Array<{
    key: string;
    value: string;
  }>;
  alignmentObjects: Array<{
    key: string;
    source: string;
    alignmentType: string;
    targetName: string;
  }>;
  suitsAllEarlyChildhoodSubjects: boolean;
  suitsAllPrePrimarySubjects: boolean;
  suitsAllBasicStudySubjects: boolean;
  suitsAllUpperSecondarySubjects: boolean;
  suitsAllUpperSecondarySubjectsNew: boolean;
  suitsAllVocationalDegrees: boolean;
  suitsAllSelfMotivatedSubjects: boolean;
  suitsAllBranches: boolean;
  accessibilityFeatures: Array<{
    key: string;
    value: string;
  }>;
  accessibilityHazards: Array<{
    key: string;
    value: string;
  }>;
  typicalAgeRange: {
    typicalAgeRangeMin: string;
    typicalAgeRangeMax: string;
  };
  timeRequired: string;
  publisher: Array<{
    key: string;
    value: string;
  }>;
  expires: string;
  prerequisites: Array<{
    key: string;
    source: string;
    alignmentType: string;
    targetName: string;
  }>;
  license: string;
  isBasedOn: {
    externals: Array<{
      author: string[];
      url: string;
      name: string;
    }>;
  };
  isVersioned: boolean;
  materials: Array<{
    materialId: string;
    priority: number;
    attachments: Array<string>;
  }>;
  fileDetails: Array<{
    id: string;
    displayName: {
      fi: string;
      sv: string;
      en: string;
    };
    language: {
      key: string;
      value: string;
    };
    link: string;
  }>;
  attachmentDetails: Array<{
    kind: string;
    default: boolean;
    label: string;
    lang: string;
    id: string;
  }>;
}

interface AuthorsOrganization {
  key: string;
  value: string;
}

/**
 * Update educational material metadata.
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 * @return {Promise<void>}
 */
export const updateEducationalMaterialMetadata = async (
  req: Request,
  res: Response,
  next: NextFunction,
): Promise<void> => {
  try {
    const metadata: EducationalMaterialMetadata = req.body;
    const emid: string = req.params.edumaterialid;

    if (!metadata || !emid) {
      return next(
        new ErrorHandler(
          400,
          'Metadata update for the educational material failed: edumaterialid=' + emid + ', metadata=' + metadata,
        ),
      );
    }
    const eduMaterial = await updateMaterial(metadata, emid);
    res.status(200).json(eduMaterial[1]);

    // Update the search index after educational material changes.
    await updateEsDocument();

    if (Number(process.env.PID_SERVICE_ENABLED) === 1 && eduMaterial[1] && eduMaterial[1].publishedat) {
      const aoeurl = await getEduMaterialVersionURL(emid, eduMaterial[1].publishedat);
      const pidurn = await pidResolutionService.registerPID(aoeurl);
      await updateEduMaterialVersionURN(emid, eduMaterial[1].publishedat, pidurn);
    } else {
      winstonLogger.error(
        'URN update skipped for the educational material #%s in updateEducationalMaterialMetadata().',
        emid,
      );
    }
  } catch (err) {
    next(
      new ErrorHandler(
        400,
        'One of the metadata updates for the educational material failed in updateEducationalMaterialMetadata().',
      ),
    );
  }
};
