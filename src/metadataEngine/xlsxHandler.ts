// handling and validating xlsx file
import { winstonLogger } from '../util';

const csv = require ("fast-csv");
const xlsx = require("xlsx");
import { Request, Response, NextFunction } from "express";
const apiQ = require("./../queries/apiQueries");
const mapper = require("./dataMapping");
const multer  = require("multer");

const fileFilter = (req: any, file: any, cb: any) => {
    if (file.mimetype === "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
        cb(undefined, true);
    }
    else {
        cb(undefined, false);
    }
};

const storage = multer.diskStorage({
    destination: function (req: any, file: any, cb: any) {
        cb(undefined, "uploads/");
    },
    filename: function (req: any, file: any, cb: any) {
        const datetimestamp = Date.now();
        cb(undefined, file.fieldname + "-" + datetimestamp + "." + file.originalname.split(".")[file.originalname.split(".").length - 1]);
    }
});

const maxFileSize = 5 * 1024 * 1024;
const upload = multer( {
    storage: storage,
    limits: {fileSize: maxFileSize},
    fileFilter : fileFilter
});

const fs = require("fs");

async function createPropertyNameList(obj: any, str: string) {
    const list: any = [];
    Object.getOwnPropertyNames(obj).forEach(
        function (val: any, idx, array) {
            if (val.includes(str)) {
                list.push(val);
            }
          }
    );
    return list;
}
async function validate(data: any) {
    const licensekoodisto = [{"type" : "cc" }, { "type" : "cc-ra"}, { "type" : "cc-dd"}, { "type" : "mit"}];
    const o: any = {};
    const key = "error";
    o[key] = [];
        for (const d in data) {
            const avainsanaList: any = await createPropertyNameList(data[d], "avainsana");
            const row = Number(d) + 2;
            // validate mandatory fields
            if (data[d].nimi === undefined) {
                o[key].push(createMessage(row, "nimi", "nimi cannot be empty"));
            }
            if (data[d].julkaisuajankohta === undefined) {
                o[key].push(createMessage(row, "julkaisuajankohta", "julkaisuajankohta cannot be empty"));
            }
            else {
                const da = data[d].julkaisuajankohta.toString();
                if (da.length !== 10) {
                    o[key].push(createMessage(row, "julkaisuajankohta", "Field must contain 8 characters. Correct format is yyyymmd"));
                }
                else if (!/\d\d[.]\d\d[.]\d\d\d\d/.test(da)) {
                    o[key].push(createMessage(row, "julkaisuajankohta", "Only numbers are allowed. Correct format is yyyymmdd"));
                }
            }
            if (data[d].linkki === undefined) {
                o[key].push(createMessage(row, "linkki", "linkki cannot be empty"));
            }
            if (data[d].tekija === undefined) {
                o[key].push(createMessage(row, "tekija", "tekija cannot be empty"));
            }
            if (data[d].organisaatio === undefined) {
                o[key].push(createMessage(row, "organisaatio", "organisaatio cannot be empty"));
            }
            if (data[d].lisenssi === undefined) {
                o[key].push(createMessage(row, "lisenssi", "lisenssi cannot be empty"));
            }
            if (data[d].kieli === undefined) {
                o[key].push(createMessage(row, "kieli", "kieli cannot be empty"));
            }
            else {
                // validate koodisto here
                // const result = validateKoodistoCode(data[d].lisenssi, licensekoodisto);
                // if (!result) {
                //     o[key].push(createMessage(row, "lisenssi", "not found from koodisto service"));
                // }
            }
            // check that row does not have dublicate data
            if (await hasDuplicates(avainsanaList, data[d])) {
                o[key].push(createMessage(row, "avainsana", "avainsana has dublicate value"));
            }
            const kohderyhmaList: any = await createPropertyNameList(data[d], "kohderyhma");
            if (await hasDuplicates(kohderyhmaList, data[d])) {
            o[key].push(createMessage(row, "kohderyhma", "kohderyhma has dublicate value"));
            }
            const oppimateriaalityyppiList: any = await createPropertyNameList(data[d], "oppimateriaalityyppi");
            if (await hasDuplicates(oppimateriaalityyppiList, data[d])) {
                o[key].push(createMessage(row, "oppimateriaalityyppi", "oppimateriaalityyppi has dublicate value"));
            }
            const saavutettavuusList: any = await createPropertyNameList(data[d], "saavutettavuus");
            if (await hasDuplicates(saavutettavuusList, data[d])) {
                o[key].push(createMessage(row, "saavutettavuus", "saavutettavuus has dublicate value"));
            }
            const oppiasteList: any = await createPropertyNameList(data[d], "oppiaste");
            if (await hasDuplicates(oppiasteList, data[d])) {
                o[key].push(createMessage(row, "oppiaste", "oppiaste has dublicate value"));
            }
            const kayttotapaList: any = await createPropertyNameList(data[d], "kaytto_opetuksessa");
            if (await hasDuplicates(kayttotapaList, data[d])) {
                o[key].push(createMessage(row, "kaytto_opetuksessa", "kaytto_opetuksessa has dublicate value"));
            }
            const julkaisijaList: any = await createPropertyNameList(data[d], "julkaisija");
            if (await hasDuplicates(julkaisijaList, data[d])) {
                o[key].push(createMessage(row, "julkaisija", "julkaisija has dublicate value"));
            }
            const opettaaList: any = await createPropertyNameList(data[d], "opettaa");
            if (await hasDuplicates(opettaaList, data[d])) {
                o[key].push(createMessage(row, "opettaa", "opettaa has dublicate value"));
            }
            const arvioiList: any = await createPropertyNameList(data[d], "arvioi");
            if (await hasDuplicates(arvioiList, data[d])) {
                o[key].push(createMessage(row, "arvioi", "arvioi has dublicate value"));
            }
            // const vaikeustasoList: any = await createPropertyNameList(data[d], "vaikeustaso");
            // if (await hasDuplicates(vaikeustasoList, data[d])) {
            //     o[key].push(createMessage(row, "vaikeustaso", "vaikeustaso has dublicate value"));
            // }
            const koulutusasteList: any = await createPropertyNameList(data[d], "koulutusaste");
            if (await hasDuplicates(koulutusasteList, data[d])) {
                o[key].push(createMessage(row, "koulutusaste", "koulutusaste has dublicate value"));
            }
            const oppiaineList: any = await createPropertyNameList(data[d], "oppiaine");
            if (await hasDuplicates(oppiaineList, data[d])) {
                o[key].push(createMessage(row, "oppiaine", "oppiaine has dublicate value"));
            }
            const alkutasovaatimusList: any = await createPropertyNameList(data[d], "alkutasovaatimus");
            if (await hasDuplicates(alkutasovaatimusList, data[d])) {
                o[key].push(createMessage(row, "alkutasovaatimus", "alkutasovaatimus has dublicate value"));
            }
            const lukutaitovaatimusList: any = await createPropertyNameList(data[d], "lukutaitovaatimus");
            if (await hasDuplicates(lukutaitovaatimusList, data[d])) {
                o[key].push(createMessage(row, "lukutaitovaatimus", "lukutaitovaatimus has dublicate value"));
            }
            const edeltavaOsaaminenList: any = await createPropertyNameList(data[d], "edeltava_osaaminen");
            if (await hasDuplicates(edeltavaOsaaminenList, data[d])) {
                o[key].push(createMessage(row, "edeltava_osaaminen", "edeltava_osaaminen has dublicate value"));
            }
            const saavutettavuudenTukitoiminnotList: any = await createPropertyNameList(data[d], "saavutettavuuden_tukitoiminnot");
            if (await hasDuplicates(saavutettavuudenTukitoiminnotList, data[d])) {
                o[key].push(createMessage(row, "saavutettavuuden_tukitoiminnot", "saavutettavuuden_tukitoiminnot has dublicate value"));
            }
            const saavutettavuudenEsteetList: any = await createPropertyNameList(data[d], "saavutettavuuden_esteet");
            if (await hasDuplicates(saavutettavuudenEsteetList, data[d])) {
                o[key].push(createMessage(row, "saavutettavuuden_esteet", "saavutettavuuden_esteet has dublicate value"));
            }
            const vaikeustasoKielissaList: any = await createPropertyNameList(data[d], "vaikeustaso_kielissa");
            if (await hasDuplicates(vaikeustasoKielissaList, data[d])) {
                o[key].push(createMessage(row, "vaikeustaso_kielissa", "vaikeustaso_kielissa has dublicate value"));
            }
        }
    return o;
}

async function hasDuplicates(array: any, obj: any) {
    const map: any = {};
    for (let i = 0; i < array.length; ++i) {
        const value = obj[array[i]];
        // if (value !== "" && value !== 0) {
            if (map[value]) {
                winstonLogger.debug("dublicate:" + value);
                return true;
            }
            map[value] = true;
        // }
    }
    return false;
}

function createMessage(row: number, column: string, reason: string) {
    const data = {
        row: row,
        column: column,
        reason: reason
    };
    return data;
}

async function uploadXlsx(req: Request, res: Response) {
    try {
        const contentType = req.headers["content-type"];
        if (contentType.startsWith("multipart/form-data")) {
            try {
                upload.single("xlsxfile")(req , res, async function() {
                    try {
                        if ((<any>req).file === undefined) {
                            return res.status(400).send("Xlsx file expected. Max file size: " + (maxFileSize / 1024 / 1024) + "MB");
                        }
                        const options = { type : "string"};
                        const wb = xlsx.readFile((<any>req).file.path, options);
                        const sheetNameList = wb.SheetNames;
                        const data = xlsx.utils.sheet_to_json(wb.Sheets["metadata"]);
                        if (data.length === 0 ) {
                            return res.status(400).send("Cannot find data in metadata sheet");
                        }
                        winstonLogger.debug(data);
                        // validate data
                        const obj: any = await validate(data);
                        const key = "error";
                        if (Object.keys(obj[key]).length > 0) {
                            winstonLogger.debug(obj);
                            fs.unlinkSync((<any>req).file.path);
                            return res.status(400).json(obj);
                        }
                        // insert to database
                        const o: any = {};
                        const rowkey = "row";
                        o[rowkey] = [];
                        for (const d in data) {
                            winstonLogger.debug("inserting row " + (Number(d) + 2));
                            const materialobj = await mapper.createMaterialObject(data[d]);
                            await apiQ.insertEducationalMaterial(materialobj, function(err: any, result: any) {
                                if (err) {
                                    o[rowkey].push({
                                        row: (Number(d) + 2),
                                        result: "error"
                                    });
                                }
                                else {
                                    o[rowkey].push({
                                        row: (Number(d) + 2),
                                        result: "success"
                                    });
                                }
                            });
                        }
                        fs.unlinkSync((<any>req).file.path);
                        res.status(200).json(o);
                    }
                    catch (err) {
                        winstonLogger.debug(err);
                        fs.unlinkSync((<any>req).file.path);
                        res.status(500).send("Error in file handling. Xlsx file expected");
                    }
                });
            }
            catch (err) {
                winstonLogger.debug(err);
                fs.unlinkSync((<any>req).file.path);
                res.status(500).send("error");
            }
        }
        else {
            res.status(400).send("Not file found");
        }
}
    catch (error) {
        winstonLogger.debug(error);
        res.status(500).send("error");
    }
}

// function validateKoodistoCode(str: String, koodisto: any) {
//         for (const key in koodisto) {
//             if (koodisto[key].type === str) {
//                 return true;
//             }
//         }
//     return false;
// }

module.exports = {
    uploadXlsx : uploadXlsx
};
