interface IActivityMetadata {
  eduMaterialId: string;
  interaction: string;
  metadata?: {
    created: string;
    updated: string;
    organizations?: string[];
    educationalLevels?: string[];
    educationalSubjects?: string[];
  };
}

export type TypeMaterialActivity = Partial<IMessageBase> & IActivityMetadata;
