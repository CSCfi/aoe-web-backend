const fh = require("./queries/fileHandling");
import { scheduleJob } from "node-schedule";
import { rmDir } from "./helpers/fileRemover";

// schedule job to start 4.00 server time
scheduleJob("4 * * *", function() {
    console.log("Removing files from html folder: " + process.env.HTMLFOLDER);
    rmDir(process.env.HTMLFOLDER, false);
});

setInterval(() => fh.checkTemporaryRecordQueue(), 3600000);
setInterval(() => fh.checkTemporaryAttachmentQueue(), 3600000);