interface IActivityMetadata {
    eduMaterialId: string;
    interaction: string;
}

export type TypeActivityMetadata = IActivityMetadata;

export type TypeMaterialActivity = Partial<IMessageBase> & IActivityMetadata;

interface StatsInterface {
    year?: string;
    month?: string;
}
