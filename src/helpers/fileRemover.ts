import { winstonLogger } from '../util/winstonLogger';

const fs = require("fs");
const path = require("path");

export function rmDir(dirPath, removeSelf) {
    try {
        const files = fs.readdirSync(dirPath);
        if (files.length > 0)
        for (let i = 0; i < files.length; i++) {
            const filePath = path.join(dirPath, files[i]);
            if (fs.statSync(filePath).isFile())
                fs.unlinkSync(filePath);
            else
                rmDir(filePath, true);
        }
        if (removeSelf)
        fs.rmdirSync(dirPath);
        }
        catch (e) {
            winstonLogger.error(e);
            return;
        }
  }
