import { BuildOptions, Model } from 'sequelize';

/**
 * Global interface and type declarations for the data persistence with Sequelize.
 * Data model structures of AOE domain are listed in alphabetical order below.
 */
declare global {
  // AOEUser
  interface AOEUser extends Model {
    username: string;
  }

  type AOEUserType = typeof Model & {
    new (values?: Record<string, unknown>, options?: BuildOptions): AOEUser;
  };

  // EducationalMaterial
  interface EducationalMaterial extends Model {
    // Removed extension IEducationalMaterial
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
    temporaryRecords?: TemporaryRecord[];
    // records: Record[];
  }

  type MaterialType = typeof Model & {
    new (values?: Record<string, unknown>, options?: BuildOptions): Material;
  };

  // MaterialDisplayName
  interface MaterialDisplayName extends Model {
    id: string;
    displayName: string;
    language: string;
    materialId: string;
  }

  type MaterialDisplayNameType = typeof Model & {
    new (values?: Record<string, unknown>, options?: BuildOptions): MaterialDisplayName;
  };

  // Notification
  enum NotificationEnum {
    ERROR,
    INFO,
  }

  interface Notification extends Model {
    id?: number;
    text: string;
    type: NotificationEnum;
    createdAt?: string;
    showSince?: string;
    showUntil?: string;
    disabled?: boolean;
    username?: string;
  }

  type NotificationType = typeof Model<Notification> & {
    new (values?: Record<string, unknown>, options?: BuildOptions): Notification;
  };

  // Record
  interface IRecord extends Model {
    id: string;
    filePath?: string;
    originalFileName: string;
    fileSize: number;
    mimeType: string;
    format?: string;
    materialId: string;
    fileKey?: string;
    fileBucket?: string;
    pdfKey?: string;
  }

  type RecordType = typeof Model & {
    new (values?: Record<string, unknown>, options?: BuildOptions): IRecord;
  };

  // TemporaryRecord
  interface TemporaryRecord extends Model {
    id: string;
    filePath: string;
    originalFileName: string;
    fileSize: number;
    mimeType: string;
    format: string;
    fileName: string;
    materialId: string;
    createdAt: Date;
  }

  type TemporaryRecordType = typeof Model & {
    new (values?: Record<string, unknown>, options?: BuildOptions): TemporaryRecord;
  };
}
