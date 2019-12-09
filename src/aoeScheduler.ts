const fh = require("./queries/fileHandling");
setInterval(() => fh.checkTemporaryRecordQueue(), 3600000);
setInterval(() => fh.checkTemporaryAttachmentQueue(), 3600000);