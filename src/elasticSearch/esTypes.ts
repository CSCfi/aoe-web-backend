export interface MultiMatchSeachBody {
    query: {
      bool: {
        must: Array<object>,
        filter?: object
      }
    };
  }

  export const expiresFilterObject = {
  "bool" : {
    "should": [{
      "range": {
        "expires": {
          "gte": "now"
        }
      }
    }, {
      "bool": {
        "must_not": {
          "exists": {
            "field": "expires"
          }
        }
      }
    }
    ]
  }
};
  export interface FilterTerm {
    term: {
      [key: string]: string
    };
  }
  export interface MatchObject {
    bool: {
      must: Array<
        {
          match: {
            [key: string]: string
        };
      }>;
    };
  }
  export interface ShardsResponse {
    total: number;
    successful: number;
    failed: number;
    skipped: number;
  }

  export interface Explanation {
    value: number;
    description: string;
    details: Explanation[];
  }

  export interface SearchResponse<T> {
    took: number;
    timed_out: boolean;
    _scroll_id?: string;
    _shards: ShardsResponse;
    hits: {
      total: {
        value: number;
        relation: string;
      }
      max_score: number;
      hits: Array<{
        _index: string;
        _type: string;
        _id: string;
        _score: number;
        _source: T;
        _version?: number;
        _explanation?: Explanation;
        fields?: any;
        highlight?: any;
        inner_hits?: any;
        matched_queries?: string[];
        sort?: string[];
      }>;
    };
    aggregations?: any;
  }
// export interface CollectionSource {
//     id: number;
//     createdat: Date;
//     publishedat: Date;
//     updatedat: Date;
//     name: string;
//     description: string;
//     keywords: Array<{
//         value: string;
//         key: string;
//     }>;
//     languages: Array<string>;
//     alignmentObjects:
// }
  export interface Source {
    id: number;
    createdat: Date;
    publishedat: Date;
    updatedat: Date;
    archivedat: Date;
    timerequired: string;
    agerangemin: string;
    agerangemax: string;
    license: {
      key: string;
      value: string;
    };
    obsoleted: number;
    originalpublishedat: Date;
    expires: Date;
    suitsallearlychildhoodsubjects: boolean;
    suitsallpreprimarysubjects: boolean;
    suitsallbasicstudysubjects: boolean;
    suitsalluppersecondarysubjects: boolean;
    suitsalluppersecondarysubjectsnew: boolean;
    suitsallvocationaldegrees: boolean;
    suitsallselfmotivatedsubjects: boolean;
    suitsallbranches: boolean;
    materials: Array<{
            id: number;
            language: string;
            link: string;
            priority: number;
            filepath: string;
            originalfilename: string;
            filesize: number;
            mimetype: string;
            format: string;
            filekey: string;
            filebucket: string;
            obsoleted: number;
            materialdisplayname: Array<{
                    id: string;
                    displayname: string;
                    language: string;
                    materialid: number;
              }>;
        }>;
    materialname: Array<{
        id: number;
        materialname: string;
        language: string;
        slug: string;
        educationalmaterialid: number;
    }>;
    materialdescription: Array<{
        id: number;
        description: string;
        language: string;
        educationalmaterialid: number;
    }>;
    educationalaudience: Array<{
        id: number;
        educationalrole: string;
        educationalmaterialid: number;
        educationalrolekey: string;
    }>;
    learningresourcetype: Array<{
        id: number;
        value: string;
        educationalmaterialid: number;
        learningresourcetypekey: string;
    }>;
    accessibilityfeature: Array<{
            id: number;
            value: string;
            educationalmaterialid: number;
            accessibilityfeaturekey: string;
    }>;
    accessibilityhazard: Array<{
      id: number;
      value: string;
      educationalmaterialid: number;
      accessibilityhazardkey: string;
    }>;
    keyword: Array<{
      id: number;
      value: string;
      educationalmaterialid: number;
      keywordkey: string;
    }>;
    educationallevel: Array<{
      id: number;
      value: string;
      educationalmaterialid: number;
      educationallevelkey: string;
    }>;
    educationaluse: Array<{
      id: number;
      value: string;
      educationalmaterialid: number;
      educationalusekey: string;
    }>;
    publisher: Array<{
    }>;
    author: Array<{
      id: number;
      authorname: string;
      organization: string;
      educationalmaterialid: number;
      organizationkey: string;
    }>;
    isbasedon: Array<{
    }>;
    inlanguage: Array<{
    }>;
    alignmentobject: Array<{
      id: number;
      educationalmaterialid: number;
      alignmenttype: string;
      targetname: string;
      source: string;
      educationalframework: string;
      objectkey: string;
      targeturl: string;
    }>;
    owner: Array<{
            firstname: string;
            lastname: string;
    }>;
    thumbnail: string;
}

// interface AoeBody {
//   hits: number;
//   results?: Array<
//     {
// _source: T;
export interface AoeRequestFilter {
  educationalLevels: Array<string>;
  learningResourceTypes: Array<string>;
  educationalSubjects: Array<string>;
  educationalRoles: Array<string>;
  authors: Array<string>;
  alignmentTypes: Array<string>;
  keywords: Array<string>;
  languages: Array<string>;
  organizations: Array<string>;
  teaches: Array<string>;
}
export interface AoeBody<T> {
    hits: number;
    results?: Array<T>;
}
export interface AoeCollectionResult {
        id?: number;
        createdat?: Date;
        publishedat?: Date;
        updatedat?: Date;
        name?: string;
        description?: string;

        alignmentObjects?: Array<{
            alignmenttype: string;
            targetname: string;
            source: string;
            educationalframework?: string;
            objectkey: string;
            targeturl?: string;
        }>;
        educationalUses: Array<{
            value: string;
            key: string;
        }>;
        accessibilityHazards: Array<{
            value: string;
            key: string;
        }>;
        accessibilityFeatures: Array<{
            value: string;
            key: string;
        }>;
        authors?: Array<string>;
        license?: {
          key: string;
          value: string;
        };
        educationalLevels?: Array<{
          value: string;
          key: string;
        }>;
        keywords?: Array<{
          value: string;
          key: string;
        }>;
        educationalRoles?: Array<{
          value: string;
          key: string;
        }>;

        languages?: Array<string>;
        thumbnail?: string;
      }
      export interface AoeResult {
        id?: number;
        createdAt?: Date;
        publishedAt?: Date;
        updatedAt?: Date;
        materialName?: Array<{
          materialname: string;
          language: string;
        }>;
        description?: Array<{
          description: string;
          language: string;
        }>;
        authors?: Array<{
          authorname: string;
          organization: string;
          organizationkey: string;
        }>;
        learningResourceTypes?: Array<{
          value: string;
          learningresourcetypekey: string;
        }>
        ;
        license?: {
          key: string;
          value: string;
        };
        educationalLevels?: Array<{
          value: string;
          educationallevelkey: string;
        }>;
        keywords?: Array<{
          value: string;
          keywordkey: string;
        }>;
        educationalRoles?: Array<{
          value: string;
          educationalrolekey: string;
        }>;

        languages?: Array<string>;
        educationalSubjects?: Array<{
          value: string;
          key: string;
          source: string;
        }>;
        teaches?: Array<{
          value: string;
          key: string;
        }>;
        thumbnail?: string;
        hasDownloadableFiles?: boolean;
      }