process.env.NODE_ENV = process.env.NODE_ENV || 'development';

export default {
  // General application start up configurations.
  APPLICATION_CONFIG: {
    isCloudStorageEnabled: (process.env.CLOUD_STORAGE_ENABLED === '1') as boolean,
  },

  // Cloud storage configurations.
  CLOUD_STORAGE_CONFIG: {
    accessKey: process.env.CLOUD_STORAGE_ACCESS_KEY as string,
    accessSecret: process.env.CLOUD_STORAGE_ACCESS_SECRET as string,
    apiURL: process.env.CLOUD_STORAGE_API as string,
    region: process.env.CLOUD_STORAGE_REGION as string,
    bucket: process.env.CLOUD_STORAGE_BUCKET as string,
    bucketPDF: process.env.CLOUD_STORAGE_BUCKET_PDF as string,
    bucketThumbnail: process.env.CLOUD_STORAGE_BUCKET_THUMBNAIL as string,
  },

  // Media file processing configurations.
  MEDIA_FILE_PROCESS: {
    htmlFolder: process.env.HTML_FOLDER as string,
    localFolder: process.env.MATERIAL_FILE_UPLOAD_FOLDER as string,
  },

  // Configuration for the client of Kafka message queue system.
  MESSAGE_QUEUE_OPTIONS: {
    kafkaProducerEnabled: (process.env.KAFKA_ENABLED === '1') as boolean,
    brokerServers: process.env.KAFKA_BROKER_SERVERS as string,
    topicMaterialActivity: process.env.KAFKA_BROKER_TOPIC_MATERIAL_ACTIVITY as string,
    topicSearchRequests: process.env.KAFKA_BROKER_TOPIC_SEARCH_REQUESTS as string,
    clientId: process.env.KAFKA_CLIENT_ID as string,
  },

  // AOE server and service component general purpose configurations.
  SERVER_CONFIG_OPTIONS: {
    oaipmhAnalyticsURL: process.env.SERVER_CONFIG_OAIPMH_ANALYTICS_URL as string,
  },

  // Session management conventions to handle session initialization and persistence.
  SESSION_CONFIG_OPTIONS: {
    proxy: (process.env.SESSION_OPTION_PROXY.toLowerCase() === 'true') as boolean,
    resave: (process.env.SESSION_OPTION_RESAVE.toLowerCase() === 'true') as boolean,
    rolling: (process.env.SESSION_OPTION_ROLLING.toLowerCase() === 'true') as boolean,
    saveUninitialized: (process.env.SESSION_OPTION_SAVE_UNINITIALIZED.toLowerCase() === 'true') as boolean,
    secret: process.env.SESSION_SECRET as string,
  },

  // Session cookie options to initialize and terminate sessions for a user.
  SESSION_COOKIE_OPTIONS: {
    domain: process.env.SESSION_COOKIE_DOMAIN as string,
    httpOnly: (process.env.SESSION_COOKIE_HTTP_ONLY.toLowerCase() === 'true') as boolean,
    maxAge: parseInt(process.env.SESSION_COOKIE_MAX_AGE, 10) as number,
    path: process.env.SESSION_COOKIE_PATH as string,
    sameSite: process.env.SESSION_COOKIE_SAME_SITE as 'lax' | 'strict' | 'none', // boolean | 'lax' | 'strict' | 'none'
    secure: (process.env.SESSION_COOKIE_SECURE.toLowerCase() === 'true') as boolean, // boolean | 'auto'
  },

  // Streaming redirect criteria to accept a media file download by streaming.
  STREAM_REDIRECT_CRITERIA: {
    mimeTypeArr: ['audio/mp4', 'audio/mpeg', 'audio/x-m4a', 'video/mp4'] as string[],
    minFileSize: parseInt(process.env.STREAM_FILESIZE_MIN, 10) as number,
    redirectUri: process.env.STREAM_REDIRECT_URI as string,
  },

  // Streaming service status request to verify a media file streaming capability.
  STREAM_STATUS_REQUEST: {
    host: process.env.STREAM_STATUS_HOST as string,
    path: process.env.STREAM_STATUS_PATH as string,
  },
};
