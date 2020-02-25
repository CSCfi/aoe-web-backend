import dotenv from "dotenv";
dotenv.config({path: ".env"});
const {elasticSearchQuery,
    createShouldObject,
    createMultiMatchObject,
    createMatchAllObject,
    filterMapper,
    aoeResponseMapper} = require ("../src/elasticSearch/esQueries");

test("create should object", () => {
    const obj = [];
    createShouldObject(obj, "teststring", ["first", "second"]);
    expect(obj).toEqual([{"bool": {"should": [{"term": {"teststring": "first"}}, {"term": {"teststring": "second"}}]}}]);
});

test("create multi match object", () => {
    const keywords = "test multi";
    const fields = ["field1", "filed2"];
    const obj = createMultiMatchObject(keywords, fields);
    expect(obj).toEqual({"multi_match": {"query": keywords, "fields": fields, "fuzziness" : "AUTO"}});
});

test("create match all object", () => {
    const obj = createMatchAllObject();
    expect(obj).toEqual({"match_all": {}});
});

test("map aoe request filters to elastic search query", () => {
    const filters = {
        "educationalLevels": [
          "key1",
          "key2"
        ],
        "learningResourceTypes": [
          "a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195",
          "key3"
        ],
        "educationalSubjects": [
            "etsi"
            ],
        "educationalRoles" : [
            "student"
            ],
        "authors": ["Jari"],
        "alignmentTypes": ["type"],
        "keywords": ["avainsana"],
        "languages": ["fi"],
        "organizations": ["csc"]
      };
    
    const obj = filterMapper(filters);
    const result = [{"bool":{"should":[{"term":{"educationallevel.educationallevelkey.keyword":"key1"}}
    ,{"term":{"educationallevel.educationallevelkey.keyword":"key2"}}]}}
    ,{"bool":{"should":[{"term":{"learningresourcetype.learningresourcetypekey.keyword":"a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195"}}
    ,{"term":{"learningresourcetype.learningresourcetypekey.keyword":"key3"}}]}}
    ,{"bool":{"should":[{"term":{"alignmentobject.objectkey.keyword":"etsi"}}]}}
    ,{"bool":{"should":[{"term":{"educationalaudience.educationalrolekey.keyword":"student"}}]}}
    ,{"bool":{"should":[{"term":{"author.authorname.keyword":"Jari"}}]}}
    ,{"bool":{"should":[{"term":{"alignmentobject.alignmenttype.keyword":"type"}}]}}
    ,{"bool":{"should":[{"term":{"keyword.keywordkey.keyword":"avainsana"}}]}}
    ,{"bool":{"should":[{"term":{"materials.language.keyword":"fi"}}]}}
    ,{"bool":{"should":[{"term":{"author.organizationkey.keyword":"csc"}}]}}]
    expect(obj).toEqual(result);
});

test("map elastic search response to aoe", async () => {
    const elaresponse = 
    {
        "body": {
            "took": 209,
            "timed_out": false,
            "_shards": {
                "total": 1,
                "successful": 1,
                "skipped": 0,
                "failed": 0
            },
            "hits": {
                "total": {
                    "value": 1,
                    "relation": "eq"
                },
                "max_score": 2.5628612,
                "hits": [{
                    "_index": "aoetest",
                    "_type": "_doc",
                    "_id": "2",
                    "_score": 2.5628612,
                    "_source": {
                        "id": "2",
                        "createdat": "2019-10-31T13:25:30.170Z",
                        "publishedat": "2020-02-14T12:11:07.881Z",
                        "updatedat": "2020-02-14T12:11:07.887Z",
                        "archivedat": "9999-01-01T00:00:00.000Z",
                        "timerequired": "3",
                        "agerangemin": -1,
                        "agerangemax": -1,
                        "licensecode": "CCBY4.0",
                        "obsoleted": 0,
                        "originalpublishedat": "2019-10-31T13:25:30.170Z",
                        "expires": "2022-01-01T00:00:00.000Z",
                        "suitsallearlychildhoodsubjects": false,
                        "suitsallpreprimarysubjects": true,
                        "suitsallbasicstudysubjects": true,
                        "suitsalluppersecondarysubjects": true,
                        "suitsallvocationaldegrees": true,
                        "suitsallselfmotivatedsubjects": true,
                        "suitsallbranches": true,
                        "materials": [{
                            "id": "2",
                            "language": "en",
                            "link": "",
                            "priority": 0,
                            "filepath": "https://testing.object.pouta.csc.fi/testikuva-1572528330137.png",
                            "originalfilename": "testikuva.png",
                            "filesize": 11760,
                            "mimetype": "image/png",
                            "format": "7bit",
                            "filekey": "testikuva-1572528330137.png",
                            "filebucket": "testing",
                            "obsoleted": 0,
                            "materialdisplayname": [{
                                "id": "10",
                                "displayname": "Tiedosto 3",
                                "language": "fi",
                                "materialid": "2"
                            }, {
                                "id": "11",
                                "displayname": "Filer 2",
                                "language": "sv",
                                "materialid": "2"
                            }, {
                                "id": "12",
                                "displayname": "File 2",
                                "language": "en",
                                "materialid": "2"
                            }]
                        }, {
                            "id": "20",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": []
                        }, {
                            "id": "25",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": [{
                                "id": "31",
                                "displayname": "Google",
                                "language": "fi",
                                "materialid": "25"
                            }, {
                                "id": "32",
                                "displayname": "goggle",
                                "language": "sv",
                                "materialid": "25"
                            }, {
                                "id": "33",
                                "displayname": "The Google",
                                "language": "en",
                                "materialid": "25"
                            }]
                        }, {
                            "id": "17",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": [{
                                "id": "19",
                                "displayname": "Google",
                                "language": "fi",
                                "materialid": "17"
                            }, {
                                "id": "20",
                                "displayname": "goggle",
                                "language": "sv",
                                "materialid": "17"
                            }, {
                                "id": "21",
                                "displayname": "The Google",
                                "language": "en",
                                "materialid": "17"
                            }]
                        }, {
                            "id": "18",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": [{
                                "id": "22",
                                "displayname": "Google",
                                "language": "fi",
                                "materialid": "18"
                            }, {
                                "id": "23",
                                "displayname": "goggle",
                                "language": "sv",
                                "materialid": "18"
                            }, {
                                "id": "24",
                                "displayname": "The Google",
                                "language": "en",
                                "materialid": "18"
                            }]
                        }, {
                            "id": "21",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": []
                        }, {
                            "id": "19",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": [{
                                "id": "25",
                                "displayname": "Google",
                                "language": "fi",
                                "materialid": "19"
                            }, {
                                "id": "26",
                                "displayname": "goggle",
                                "language": "sv",
                                "materialid": "19"
                            }, {
                                "id": "27",
                                "displayname": "The Google",
                                "language": "en",
                                "materialid": "19"
                            }]
                        }, {
                            "id": "24",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": [{
                                "id": "28",
                                "displayname": "Google",
                                "language": "fi",
                                "materialid": "24"
                            }, {
                                "id": "29",
                                "displayname": "goggle",
                                "language": "sv",
                                "materialid": "24"
                            }, {
                                "id": "30",
                                "displayname": "The Google",
                                "language": "en",
                                "materialid": "24"
                            }]
                        }, {
                            "id": "16",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": []
                        }, {
                            "id": "23",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": []
                        }, {
                            "id": "22",
                            "language": "fi",
                            "link": "http://csc.fi",
                            "priority": 0,
                            "filepath": null,
                            "originalfilename": null,
                            "filesize": null,
                            "mimetype": null,
                            "format": null,
                            "filekey": null,
                            "filebucket": null,
                            "obsoleted": 0,
                            "materialdisplayname": []
                        }],
                        "materialname": [{
                            "id": "31",
                            "materialname": "",
                            "language": "fi",
                            "slug": "",
                            "educationalmaterialid": "2"
                        }, {
                            "id": "32",
                            "materialname": "sävärige",
                            "language": "sv",
                            "slug": "",
                            "educationalmaterialid": "2"
                        }, {
                            "id": "33",
                            "materialname": "",
                            "language": "en",
                            "slug": "",
                            "educationalmaterialid": "2"
                        }],
                        "materialdescription": [{
                            "id": "31",
                            "description": "Kuvaus",
                            "language": "fi",
                            "educationalmaterialid": "2"
                        }, {
                            "id": "32",
                            "description": "svkuvaus",
                            "language": "sv",
                            "educationalmaterialid": "2"
                        }, {
                            "id": "33",
                            "description": "description",
                            "language": "en",
                            "educationalmaterialid": "2"
                        }],
                        "educationalaudience": [{
                            "id": "244",
                            "educationalrole": "teachers",
                            "educationalmaterialid": "2",
                            "educationalrolekey": "key1"
                        }, {
                            "id": "245",
                            "educationalrole": "student",
                            "educationalmaterialid": "2",
                            "educationalrolekey": "key2"
                        }, {
                            "id": "246",
                            "educationalrole": "student2",
                            "educationalmaterialid": "2",
                            "educationalrolekey": "key3"
                        }],
                        "learningresourcetype": [{
                            "id": "166",
                            "value": "uusi",
                            "educationalmaterialid": "2",
                            "learningresourcetypekey": "key6"
                        }, {
                            "id": "167",
                            "value": "lr3",
                            "educationalmaterialid": "2",
                            "learningresourcetypekey": "key3"
                        }],
                        "accessibilityfeature": [{
                            "id": "129",
                            "value": "tableOfContents",
                            "educationalmaterialid": "2",
                            "accessibilityfeaturekey": "key1"
                        }, {
                            "id": "130",
                            "value": "annotations",
                            "educationalmaterialid": "2",
                            "accessibilityfeaturekey": "key4"
                        }],
                        "accessibilityhazard": [{
                            "id": "129",
                            "value": "flashing",
                            "educationalmaterialid": "2",
                            "accessibilityhazardkey": "key1"
                        }, {
                            "id": "130",
                            "value": "sound",
                            "educationalmaterialid": "2",
                            "accessibilityhazardkey": "key2"
                        }],
                        "keyword": [{
                            "id": "162",
                            "value": "ympäristötietoisuus",
                            "educationalmaterialid": "2",
                            "keywordkey": "p10"
                        }, {
                            "id": "163",
                            "value": "toinen sana",
                            "educationalmaterialid": "2",
                            "keywordkey": "p2"
                        }],
                        "educationallevel": [{
                            "id": "131",
                            "value": "ala-aste2",
                            "educationalmaterialid": "2",
                            "educationallevelkey": "key2"
                        }],
                        "educationaluse": [{
                            "id": "168",
                            "value": "educationalUse123",
                            "educationalmaterialid": "2",
                            "educationalusekey": "key1"
                        }, {
                            "id": "169",
                            "value": "educationalUse2",
                            "educationalmaterialid": "2",
                            "educationalusekey": "key3"
                        }],
                        "publisher": [{
                            "id": "151",
                            "name": "adsas33",
                            "educationalmaterialid": "2",
                            "publisherkey": "uusi2"
                        }, {
                            "id": "152",
                            "name": "CSC",
                            "educationalmaterialid": "2",
                            "publisherkey": "CSC"
                        }],
                        "author": [{
                            "id": "245",
                            "authorname": "Testinen, Testi",
                            "organization": "A. Hätinen Oy",
                            "educationalmaterialid": "2",
                            "organizationkey": "1.2.246.562.10.58952610762"
                        }, {
                            "id": "246",
                            "authorname": "Testinen, Toinen",
                            "organization": "",
                            "educationalmaterialid": "2",
                            "organizationkey": ""
                        }, {
                            "id": "247",
                            "authorname": "",
                            "organization": "Aalto-yliopisto",
                            "educationalmaterialid": "2",
                            "organizationkey": "1.2.246.562.10.56753942459"
                        }],
                        "isbasedon": [{
                            "id": "143",
                            "url": "uusi.example://url.fi",
                            "materialname": "Kalevin vala2",
                            "educationalmaterialid": "2",
                            "author": [{
                                "id": "55",
                                "authorname": "Meikäläinen, Matti",
                                "isbasedonid": "143"
                            }, {
                                "id": "56",
                                "authorname": "Teikäläinen, Teppo",
                                "isbasedonid": "143"
                            }, {
                                "id": "57",
                                "authorname": "Organisaatio Oy Ab",
                                "isbasedonid": "143"
                            }]
                        }, {
                            "id": "144",
                            "url": "example://url.fi",
                            "materialname": "Kalevin vala",
                            "educationalmaterialid": "2",
                            "author": [{
                                "id": "58",
                                "authorname": "Seppo",
                                "isbasedonid": "144"
                            }]
                        }],
                        "inlanguage": [{
                            "id": "5",
                            "inlanguage": "fi",
                            "url": "example.fi",
                            "educationalmaterialid": "2"
                        }, {
                            "id": "6",
                            "inlanguage": "en",
                            "url": "example.fi",
                            "educationalmaterialid": "2"
                        }],
                        "alignmentobject": [{
                            "id": "174",
                            "educationalmaterialid": "2",
                            "alignmenttype": "teaches",
                            "targetname": "ma",
                            "source": "koodisto2",
                            "educationalframework": "A1",
                            "objectkey": "key1",
                            "targeturl": "testurl"
                        }, {
                            "id": "176",
                            "educationalmaterialid": "2",
                            "alignmenttype": "teaches2",
                            "targetname": "ma",
                            "source": "koodisto1",
                            "educationalframework": "",
                            "objectkey": "key3",
                            "targeturl": "testurl"
                        }, {
                            "id": "229",
                            "educationalmaterialid": "2",
                            "alignmenttype": "teaches",
                            "targetname": "etsi",
                            "source": "koodisto1",
                            "educationalframework": "A1",
                            "objectkey": "key2",
                            "targeturl": "testurl"
                        }],
                        "owner": [{
                            "firstname": "Jari",
                            "lastname": "Aarni"
                        }],
                        "thumbnail": null
                    }
                }]
            }
        },
        "statusCode": 200,
        "headers": {
            "content-type": "application/json; charset=UTF-8",
            "content-length": "8486"
        },
        "warnings": null,
        "meta": {
            "context": null,
            "request": {
                "params": {
                    "method": "POST",
                    "path": "/aoetest/_search",
                    "body": "{\"query\":{\"bool\":{\"must\":[{\"multi_match\":{\"query\":\"ympäristötietoisuus\",\"fields\":[\"accessibilityfeature.value\",\"accessibilityhazard.value\",\"alignmentobject.targetname\",\"alignmentobject.educationalframework\",\"author.authorname\",\"author.organization\",\"educationalaudience.educationalrole\",\"educationallevel.value\",\"educationaluse.value\",\"inlanguage.inlanguage\",\"isbasedon.author\",\"isbasedon.materialname\",\"keyword.value\",\"learningresourcetype.value\",\"licensecode\",\"materialdescription.description\",\"materialname.materialname\",\"materials.materialdisplayname.displayname\",\"materials.link\",\"materials.originalfilename\",\"owner.firstname\",\"owner.lastname\",\"publisher.name\"],\"fuzziness\":\"AUTO\"}},{\"bool\":{\"should\":[{\"term\":{\"educationallevel.educationallevelkey.keyword\":\"3ff553ba-a4d7-407c-ad00-80e54ecebd16\"}},{\"term\":{\"educationallevel.educationallevelkey.keyword\":\"94f79e1e-10e6-483d-b651-27521f94f7bf\"}},{\"term\":{\"educationallevel.educationallevelkey.keyword\":\"key2\"}}]}},{\"bool\":{\"should\":[{\"term\":{\"learningresourcetype.learningresourcetypekey.keyword\":\"a42b00b6-c2a7-407d-ba6b-8e7a4fb3e195\"}},{\"term\":{\"learningresourcetype.learningresourcetypekey.keyword\":\"7be52f46-138d-482f-834e-5ea33d933c37\"}},{\"term\":{\"learningresourcetype.learningresourcetypekey.keyword\":\"bf2c17a1-2f6f-4019-adb1-576e6caeebd9\"}},{\"term\":{\"learningresourcetype.learningresourcetypekey.keyword\":\"key3\"}}]}},{\"bool\":{\"should\":[{\"term\":{\"alignmentobject.targetname.keyword\":\"etsi\"}}]}}]}}}",
                    "querystring": "from=0&size=100",
                    "headers": {
                        "User-Agent": "elasticsearch-js/7.6.0 (linux 3.10.0-957.5.1.el7.x86_64-x64; Node.js v12.13.0)",
                        "Content-Type": "application/json",
                        "Content-Length": "1461"
                    },
                    "timeout": 30000
                },
                "options": {
                    "warnings": null
                },
                "id": 1
            },
            "name": "elasticsearch-js",
            "connection": {
                "url": "http://10.0.2.2:9200/",
                "id": "http://10.0.2.2:9200/",
                "headers": {},
                "deadCount": 0,
                "resurrectTimeout": 0,
                "_openRequests": 0,
                "status": "alive",
                "roles": {
                    "master": true,
                    "data": true,
                    "ingest": true,
                    "ml": false
                }
            },
            "attempts": 0,
            "aborted": false
        }
    }
    const obj = await aoeResponseMapper(elaresponse);
    const result = {
        "hits": 1,
        "results": [
            {
                "id": "2",
                "createdAt": "2019-10-31T13:25:30.170Z",
                "publishedAt": "2020-02-14T12:11:07.881Z",
                "updatedAt": "2020-02-14T12:11:07.887Z",
                "materialName": [
                    {
                        "materialname": "",
                        "language": "fi"
                    },
                    {
                        "materialname": "sävärige",
                        "language": "sv"
                    },
                    {
                        "materialname": "",
                        "language": "en"
                    }
                ],
                "description": [
                    {
                        "description": "Kuvaus",
                        "language": "fi"
                    },
                    {
                        "description": "svkuvaus",
                        "language": "sv"
                    },
                    {
                        "description": "description",
                        "language": "en"
                    }
                ],
                "authors": [
                    {
                        "authorname": "Testinen, Testi",
                        "organization": "A. Hätinen Oy",
                        "organizationkey": "1.2.246.562.10.58952610762"
                    },
                    {
                        "authorname": "Testinen, Toinen",
                        "organization": "",
                        "organizationkey": ""
                    },
                    {
                        "authorname": "",
                        "organization": "Aalto-yliopisto",
                        "organizationkey": "1.2.246.562.10.56753942459"
                    }
                ],
                "learningResourceTypes": [
                    {
                        "value": "uusi",
                        "learningresourcetypekey": "key6"
                    },
                    {
                        "value": "lr3",
                        "learningresourcetypekey": "key3"
                    }
                ],
                "license": "CCBY4.0",
                "educationLevels": [
                    {
                        "value": "ala-aste2",
                        "educationallevelkey": "key2"
                    }
                ],
                "thumbnail": null
            }
        ]
    }
    expect(obj).toEqual(result);
});

elasticSearchQuery