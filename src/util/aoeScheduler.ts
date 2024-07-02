import config from '@/config';
import { rmDir } from '@/helpers/fileRemover';
import { scheduledConvertAndUpstreamOfficeFilesToCloudStorage } from '@/helpers/officeToPdfConverter';
import { updateEsDocument } from '@search/es';
import { sendExpirationMail, sendRatingNotificationMail, sendSystemNotification } from '@services/mailService';
import pidResolutionService from '@services/pidResolutionService';
import winstonLogger from '@util/winstonLogger';
import { Job, scheduleJob } from 'node-schedule';

// 1:00 AM (UTC): scheduled directory cleaning tasks.
export const startScheduledCleaning = (): void => {
  const dirCleaningScheduler: Job = scheduleJob('0 0 1 * * *', async (): Promise<void> => {
    // Remove temporary content from the resource directories (H5P, HTML).
    try {
      rmDir(config.MEDIA_FILE_PROCESS.htmlFolder, false);
      rmDir(config.MEDIA_FILE_PROCESS.h5pPathContent, false);
      rmDir(config.MEDIA_FILE_PROCESS.h5pPathLibraries, false);
      rmDir(config.MEDIA_FILE_PROCESS.h5pPathTemporaryStorage, false);
      winstonLogger.debug('Scheduled removal for temporary H5P and HTML content completed.');
    } catch (err: unknown) {
      winstonLogger.error('Scheduled removal for temporary H5P or HTML content failed: %o', err);
      await sendSystemNotification('Scheduled directory cleaning at 1:00 AM (UTC) has failed and interrupted.');
      dirCleaningScheduler.cancel();
    }
  });
  winstonLogger.info('Scheduled job active for directory cleaning at 1:00 AM (UTC)');
};

// 1:15 AM (UTC): scheduled PID (Permanent Identifiers) registration for recently published educational materials.
export const startScheduledRegistrationForPIDs = (): void => {
  const pidRegisterScheduler: Job = scheduleJob('0 15 1 * * *', async (): Promise<void> => {
    try {
      if (
        (parseInt(process.env.PID_SERVICE_ENABLED, 10) as number) === 1 &&
        (parseInt(process.env.PID_SERVICE_RUN_SCHEDULED, 10) as number) === 1
      ) {
        await pidResolutionService.processEntriesWithoutPID();
        winstonLogger.debug('Scheduled PID registration for recently published educational materials completed.');
      }
    } catch (err: unknown) {
      winstonLogger.error('Scheduled PID registration for recently published educational materials failed: %o', err);
      await sendSystemNotification('Scheduled PID registration at 1:15 AM (UTC) has failed and interrupted.');
      pidRegisterScheduler.cancel();
    }
  });
  winstonLogger.info('Scheduled job active for PID registration at 1:15 AM (UTC)');
};

// 1:30 AM (UTC): scheduled search index update.
export const startScheduledSearchIndexUpdate = (): void => {
  const searchUpdateScheduler: Job = scheduleJob('0 30 1 * * *', async (): Promise<void> => {
    // Update search engine index with recent changes.
    try {
      await updateEsDocument(true);
      winstonLogger.debug('Scheduled index update for the search engine completed.');
    } catch (err: unknown) {
      winstonLogger.error('Scheduled index update for the search engine failed: %o', err);
      await sendSystemNotification('Scheduled search index update at 4:30 AM has failed and interrupted.');
      searchUpdateScheduler.cancel();
    }
  });
  winstonLogger.info('Scheduled job active for search index update at 1:30 AM (UTC)');
};

scheduleJob('0 0 10 * * *', async (): Promise<void> => {
  try {
    await sendRatingNotificationMail();
    await sendExpirationMail();
  } catch (err: unknown) {
    winstonLogger.error('Sending scheduled expiration or rating notification mail failed: %o', err);
  }
});
if (config.MEDIA_FILE_PROCESS.conversionToPdfEnabled) {
  // wait 10 seconds before start
  const sleep = (ms: number) => {
    return new Promise((resolve) => setTimeout(resolve, ms));
  };
  sleep(10000).then((): void => {
    void scheduledConvertAndUpstreamOfficeFilesToCloudStorage();
  });
}

export default {
  startScheduledCleaning,
  startScheduledRegistrationForPIDs,
  startScheduledSearchIndexUpdate,
};
