import { ISearchFilters, ISearchKeywords } from './ISearchOptions';

interface ISearchMessageBase {
    sessionId: string;
    timestamp: string;
}

export type SearchMessageType = Partial<ISearchMessageBase> & (ISearchKeywords | ISearchFilters);
