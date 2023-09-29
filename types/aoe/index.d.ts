import { BuildOptions, Model } from 'sequelize';

/**
 * Global interface and type declarations for the data persistence with Sequelize.
 * Data model structures of AOE domain are listed in alphabetical order below.
 */
declare global {
  // EducationalMaterial
  interface EducationalMaterial extends Model, IEducationalMaterial {
    id: string;
    createdAt: Date;
    publishedAt?: Date;
    updatedAt: Date;
    archivedAt?: Date;
    timeRequired: string;
    ageRangeMin?: number;
    ageRangeMax?: number;
    licenseCode: string;
    obsoleted: number;
    originalPublishedAt: Date;
    usersUserName: string;
    expires?: Date;

    // Educational Suitability
    suitsAllEarlyChildhoodSubjects: boolean;
    suitsAllPreprimarySubjects: boolean;
    suitsAllBasicStudySubjects: boolean;
    suitsAllUpperSecondarySubjects: boolean;
    suitsAllVocationalDegrees: boolean;
    suitsAllSelfmotivatedSubjects: boolean;
    suitsAllBranches: boolean;
    suitsAllUpperSecondarySubjectsNew: boolean;

    // Counters
    ratingContentAverage: number;
    ratingVisualAverage: number;
    viewCounter: string;
    downloadCounter: string;
    counterUpdatedAt: Date;

    // Reference Information
    materials?: Material[];
  }

  type EducationalMaterialType = typeof Model & {
    new (values?: Record<string, unknown>, options?: BuildOptions): EducationalMaterial;
  };

  // Material
  interface Material extends Model {
    id: string;
    link: string;
    educationalMaterialId: string;
    obsoleted: number;
    priority: number;
    materialLanguageKey: string;

    // Reference Information
    materialDisplayNames?: MaterialDisplayName[];
    // records: Record[];

    // Temporary Information
    // temporaryRecords: TemporaryRecord[];
  }

  type MaterialType = typeof Model & {
    new (values?: Record<string, unknown>, options?: BuildOptions): Material;
  };

  // MaterialDisplayName
  interface MaterialDisplayName extends Model {
    id: string;
    displayName: string;
    language: string;
    materialId: number;
  }

  type MaterialDisplayNameType = typeof Model & {
    new (values?: Record<string, unknown>, options?: BuildOptions): MaterialDisplayName;
  };
}
