import fh from '../queries/fileHandling';
import { scheduleJob } from 'node-schedule';
import { rmDir } from '../helpers/fileRemover';
import { updateEsDocument } from '../elasticSearch/es';
import { sendExpirationMail, sendRatingNotificationMail, sendSystemNotification } from '../services/mailService';
import { convertAndUpstreamOfficeFilesToCloudStorage } from '../helpers/officeToPdfConverter';
import { pidResolutionService } from '../services';
import { winstonLogger } from './winstonLogger';

// 1:00 AM (UTC): scheduled directory cleaning tasks.
export const startScheduledCleaning = (): void => {
  const dirCleaningScheduler = scheduleJob('0 0 1 * * *', async () => {
    // Remove temporary content from the resource directories (H5P, HTML).
    try {
      rmDir(process.env.HTMLFOLDER, false);
      rmDir(process.env.H5PFOLDER + '/content', false);
      rmDir(process.env.H5PFOLDER + '/libraries', false);
      rmDir(process.env.H5PFOLDER + '/temporary-storage', false);
      winstonLogger.debug('Scheduled removal for temporary H5P and HTML content completed.');
    } catch (error) {
      winstonLogger.error('Scheduled removal for temporary H5P and HTML content failed: %o', error);
      await sendSystemNotification('Scheduled directory cleaning at 1:00 AM (UTC) has failed and interrupted.');
      dirCleaningScheduler.cancel();
    }
  });
  winstonLogger.info('Scheduled job active for directory cleaning at 1:00 AM (UTC)');
};

// 1:15 AM (UTC): scheduled PID (Permanent Identifiers) registration for recently published educational materials.
export const startScheduledRegistrationForPIDs = (): void => {
  const pidRegisterScheduler = scheduleJob('0 15 1 * * *', async () => {
    try {
      if (
        (parseInt(process.env.PID_SERVICE_ENABLED, 10) as number) === 1 &&
        (parseInt(process.env.PID_SERVICE_RUN_SCHEDULED, 10) as number) === 1
      ) {
        await pidResolutionService.processEntriesWithoutPID();
        winstonLogger.debug('Scheduled PID registration for recently published educational materials completed.');
      }
    } catch (error) {
      winstonLogger.error('Scheduled PID registration for recently published educational materials failed: %o', error);
      await sendSystemNotification('Scheduled PID registration at 1:15 AM (UTC) has failed and interrupted.');
      pidRegisterScheduler.cancel();
    }
  });
  winstonLogger.info('Scheduled job active for PID registration at 1:15 AM (UTC)');
};

// 1:30 AM (UTC): scheduled search index update.
export const startScheduledSearchIndexUpdate = (): void => {
  const searchUpdateScheduler = scheduleJob('0 30 1 * * *', async () => {
    // Update search engine index with recent changes.
    try {
      await updateEsDocument(true);
      winstonLogger.debug('Scheduled index update for the search engine completed.');
    } catch (error) {
      winstonLogger.error('Scheduled index update for the search engine failed: %o', error);
      await sendSystemNotification('Scheduled search index update at 4:30 AM has failed and interrupted.');
      searchUpdateScheduler.cancel();
    }
  });
  winstonLogger.info('Scheduled job active for search index update at 1:30 AM (UTC)');
};

/**
 * TODO: To be refactored
 */
scheduleJob('0 0 10 * * *', async () => {
  try {
    await sendRatingNotificationMail();
    await sendExpirationMail();
  } catch (error) {
    winstonLogger.error(error);
  }
});
setInterval(() => fh.checkTemporaryRecordQueue(), 3600000);
setInterval(() => fh.checkTemporaryAttachmentQueue(), 3600000);
const officeToPdf = Number(process.env.RUN_OFFICE_TO_PDF);
if (officeToPdf === 1) {
  // wait 10 seconds before start
  const sleep = (ms) => {
    return new Promise((resolve) => setTimeout(resolve, ms));
  };
  sleep(10000).then(() => {
    // winstonLogger.debug('Start convertAndUpstreamOfficeFilesToCloudStorage');
    convertAndUpstreamOfficeFilesToCloudStorage().then();
  });
}

export default {
  startScheduledCleaning,
  startScheduledRegistrationForPIDs,
  startScheduledSearchIndexUpdate,
};
