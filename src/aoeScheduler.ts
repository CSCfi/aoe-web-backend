const fh = require("./queries/fileHandling");
import { scheduleJob } from "node-schedule";
import { rmDir } from "./helpers/fileRemover";
import { updateEsDocument } from "./elasticSearch/es";
import { sendExpirationMail, sendRatingNotificationMail } from "./services/mailService";

// schedule job to start 4.00 server time
scheduleJob("0 0 4 * * *", function() {
    console.log("Removing files from html folder: " + process.env.HTMLFOLDER);
    rmDir(process.env.HTMLFOLDER, false);
    console.log("Removing H5P files");
    rmDir(process.env.H5PFOLDER + "/content", false);
    rmDir(process.env.H5PFOLDER + "/libraries", false);
    rmDir(process.env.H5PFOLDER + "/temporary-storage", false);
    console.log("update ES");
    updateEsDocument(true);
});
scheduleJob("0 0 10 * * *", function() {
    try {
        console.log("sendRatingNotificationMail");
        sendRatingNotificationMail();
        console.log("sendExpirationMail");
        sendExpirationMail();
    }
    catch (error) {
        console.error(error);
    }
});

setInterval(() => fh.checkTemporaryRecordQueue(), 3600000);
setInterval(() => fh.checkTemporaryAttachmentQueue(), 3600000);

import { officeFilesToAllasAsPdf } from "./helpers/officeToPdfConverter";
const sleep = ms => {
    return new Promise(resolve => setTimeout(resolve, ms));
  };
sleep(10000).then(() =>
officeFilesToAllasAsPdf()
);