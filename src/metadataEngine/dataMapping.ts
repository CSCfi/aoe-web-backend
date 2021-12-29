import { winstonLogger } from '../util';

async function createMaterialObject(indata: any) {
    let obj: any = {};
    let data = await createEducationalMaterialObject(indata);
    obj = Object.assign(obj, data);
    data = await createMaterialNameObject(indata);
    obj = Object.assign(obj, data);
    data = await createDescriptionObject(indata);
    obj = Object.assign(obj, data);
    data = await createEducationalAudienceObject(indata);
    obj = Object.assign(obj, data);
    data = await createLearningResourceTypeObject(indata);
    obj = Object.assign(obj, data);
    data = await createKeyWordObject(indata);
    obj = Object.assign(obj, data);
    data = await createEducationalLevelObject(indata);
    obj = Object.assign(obj, data);
    data = await createEducationalUseObject(indata);
    obj = Object.assign(obj, data);
    data = await createPublisherObject(indata);
    obj = Object.assign(obj, data);
    data = await createInLanguageObject(indata);
    obj = Object.assign(obj, data);
    data = await createAlignmentObjectObject(indata);
    obj = Object.assign(obj, data);
    data = await createAccessibilityFeatureObject(indata);
    obj = Object.assign(obj, data);
    data = await createAccessibilityHazardObject(indata);
    obj = Object.assign(obj, data);
    data = await createMaterialTableObject(indata);
    obj = Object.assign(obj, data);
    data = await createAuthorObject(indata);
    obj = Object.assign(obj, data);
    return obj;
}

async function createPropertyNameList(obj: any, str: string) {
    const list: any = [];
    Object.getOwnPropertyNames(obj).forEach(
        function (val: any, idx, array) {
            // startsWith val.includes(str)
            if (val.startsWith(str)) {
                list.push(val);
            }
          }
    );
    return list;
}

function parseDate(dateString: string) {
    const parts = dateString.split(".");
    const date  = new Date(Number(parts[2]), (Number(parts[1]) - 1), Number(parts[0]));
    return date;
}

async function createEducationalMaterialObject(indata: any) {
    const obj: any = {};
    const key = "educationalmaterial";
    obj[key] = [];
    const date = new Date(Date.now());
    winstonLogger.debug(date);
    winstonLogger.debug(indata.julkaisuajankohta.replace(/\./g, "/"));
    const cleanJulkaisuAjankohta = parseDate(indata.julkaisuajankohta);
    const cleanOppimateriaaliVanhenee = parseDate(indata.oppimateriaali_vanhenee);
    winstonLogger.debug(cleanJulkaisuAjankohta);
    const materialData = {
        technicalname : indata.nimi,
        createdat : date,
        originalpublishedat : cleanJulkaisuAjankohta,
        publishedat : date,
        updatedat : date,
        archivedat : cleanOppimateriaaliVanhenee,
        timerequired : indata.Opiskeluun_kuluva_aika_tunneissa || 0,
        agerangemin : indata.kohderyhman_minimi_ika || 1,
        agerangemax : indata.maksimi_ika || 99,
        username : "ttk3.s@csc.fi",
        licensecode : indata.lisenssi
    };
    obj[key].push(materialData);
    return obj;
}
function createMaterialNameObject(indata: any) {
    const obj: any = {};
    const key = "MaterialName";
    obj[key] = [];
    if (indata.nimi) {
        const data = {
            MaterialName : indata.nimi,
            Language : "fi",
            Slug : indata.nimi
        };
        obj[key].push(data);
    }
    if (indata.nimi_englanti) {
        const data = {
            MaterialName : indata.nimi_englanti,
            Language : "en",
            Slug : indata.nimi_englanti
        };
        obj[key].push(data);
    }
    if (indata.nimi_ruotsi) {
        const data = {
            MaterialName : indata.nimi_ruotsi,
            Language : "sv",
            Slug : indata.nimi_ruotsi
        };
        obj[key].push(data);
    }
    return obj;
}

function createDescriptionObject(indata: any) {
    const obj: any = {};
    const key = "Description";
    obj[key] = [];
    if (indata.kuvaus) {
        const data = {
            Description : indata.kuvaus,
            Language : "fi"
        };
        obj[key].push(data);
    }
    if (indata.kuvaus_englanti) {
        const data = {
            Description : indata.kuvaus_englanti,
            Language : "en"
        };
        obj[key].push(data);
    }
    if (indata.kuvaus_ruotsi) {
        const data = {
            Description : indata.kuvaus_ruotsi,
            Language : "sv"
        };
        obj[key].push(data);
    }
    return obj;
}

async function createEducationalAudienceObject(indata: any) {
    const obj: any = {};
    const key = "EducationalAudience";
    obj[key] = [];
    const kohderyhmaList: any = await createPropertyNameList(indata, "kohderyhma");
    for (let i = 0; i < kohderyhmaList.length; ++i) {
        const value = indata[kohderyhmaList[i]];
        const data = {
            EducationalRole : value
        };
        obj[key].push(data);
    }
    return obj;
}

async function createLearningResourceTypeObject(indata: any) {
    const obj: any = {};
    const key = "LearningResourceType";
    obj[key] = [];
    const list: any = await createPropertyNameList(indata, "oppimateriaalityyppi");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            value : value
        };
        obj[key].push(data);
    }
    return obj;
}

async function createKeyWordObject(indata: any) {
    const obj: any = {};
    const key = "KeyWord";
    obj[key] = [];
    const list: any = await createPropertyNameList(indata, "avainsana");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            value : value
        };
        obj[key].push(data);
    }
    return obj;
}

async function createEducationalLevelObject(indata: any) {
    const obj: any = {};
    const key = "EducationalLevel";
    obj[key] = [];
    const list: any = await createPropertyNameList(indata, "oppiaste");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            value : value
        };
        obj[key].push(data);
    }
    return obj;
}

async function createEducationalUseObject(indata: any) {
    const obj: any = {};
    const key = "EducationalUse";
    obj[key] = [];
    const list: any = await createPropertyNameList(indata, "kaytto_opetuksessa");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            value : value
        };
        obj[key].push(data);
    }
    return obj;
}

async function createPublisherObject(indata: any) {
    const obj: any = {};
    const key = "Publisher";
    obj[key] = [];
    const list: any = await createPropertyNameList(indata, "julkaisija");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            name : value
        };
        obj[key].push(data);
    }
    return obj;
}

async function createInLanguageObject(indata: any) {
    const obj: any = {};
    const key = "InLanguage";
    obj[key] = [];
    const list: any = await createPropertyNameList(indata, "kieli");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            name : value
        };
        obj[key].push(data);
    }
    return obj;
}

async function createAccessibilityFeatureObject(indata: any) {
    const obj: any = {};
    const key = "AccessibilityFeature";
    obj[key] = [];
    const list: any = await createPropertyNameList(indata, "saavutettavuuden_tukitoiminnot");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            value : value
        };
        obj[key].push(data);
    }
    return obj;
}

async function createAccessibilityHazardObject(indata: any) {
    const obj: any = {};
    const key = "AccessibilityHazard";
    obj[key] = [];
    const list: any = await createPropertyNameList(indata, "saavutettavuuden_esteet");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            value : value
        };
        obj[key].push(data);
    }
    return obj;
}

async function createMaterialTableObject(indata: any) {
    const obj: any = {};
    const key = "Material";
    obj[key] = [];
    const materialData = {
        materialname : indata.nimi,
        link : indata.linkki,
        priority : "1"
    };
    obj[key].push(materialData);
    return obj;
}

async function createAuthorObject(indata: any) {
    const obj: any = {};
    const key = "Author";
    obj[key] = [];
    const materialData = {
        authorname : indata.tekija,
        organization : indata.organisaatio
    };
    obj[key].push(materialData);
    return obj;
}

function splitSourceValue(indata: any) {
    // expecting Peruskoulutus,koodi
    return indata.split(",");
}

async function createAlignmentObjectObject(indata: any) {
    const obj: any = {};
    const key = "AlignmentObject";
    obj[key] = [];
    let list: any = await createPropertyNameList(indata, "opettaa");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            alignmenttype : "teaches",
            targetname : value,
            source : "opettaa"
        };
        obj[key].push(data);
    }
    list = await createPropertyNameList(indata, "arvioi");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            alignmenttype : "assesses",
            targetname : value,
            source : "arvioi"
        };
        obj[key].push(data);
    }
    list = await createPropertyNameList(indata, "vaikeustaso_kielissa");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            alignmenttype : "complexitylevel",
            targetname : value,
            source : "vaikeustaso_kielissa"
        };
        obj[key].push(data);
    }
    list = await createPropertyNameList(indata, "koulutusaste");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            alignmenttype : "educationallevel",
            targetname : value,
            source : "koulutusaste"
        };
        obj[key].push(data);
    }
    list = await createPropertyNameList(indata, "edeltava_osaaminen");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            alignmenttype : "prerequisite",
            targetname : value,
            source : "edeltava_osaaminen"
        };
        obj[key].push(data);
    }
    list = await createPropertyNameList(indata, "lukutaitovaatimus");
    for (let i = 0; i < list.length; ++i) {
        const value = indata[list[i]];
        const data = {
            alignmenttype : "readinglevel",
            targetname : value,
            source : "lukutaitovaatimus"
        };
        obj[key].push(data);
    }
    list = await createPropertyNameList(indata, "oppiaine");
    for (let i = 0; i < list.length; ++i) {
        const value = splitSourceValue(indata[list[i]]);
        const data = {
            alignmenttype : "educationalsubject",
            targetname : value[1],
            source : value[0].toLowerCase()
        };
        obj[key].push(data);
    }
    return obj;
}

module.exports = {
    createMaterialObject : createMaterialObject
};
