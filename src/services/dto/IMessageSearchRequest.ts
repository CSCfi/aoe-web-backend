export interface ISearchKeywords {
    keywords: string;
}

export interface ISearchFilters {
    filters: {
        educationalLevels: string[],
        educationalSubjects: string[],
        learningResourceTypes: string[],
    }
}

export type TypeSearchOptions = ISearchKeywords | ISearchFilters;

export type TypeSearchRequest = Partial<IMessageBase> & (ISearchKeywords | ISearchFilters);
