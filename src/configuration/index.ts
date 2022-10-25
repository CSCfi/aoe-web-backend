process.env.NODE_ENV = process.env.NODE_ENV || 'development';

export default {

    // Session cookie options to initialize and terminate sessions for a user.
    SESSION_COOKIE_OPTIONS: {
        domain: process.env.SESSION_COOKIE_DOMAIN as string,
        httpOnly: (process.env.SESSION_COOKIE_HTTPONLY.toLowerCase() === 'true') as boolean,
        maxAge: parseInt(process.env.SESSION_COOKIE_MAX_AGE, 10) as number,
        path: process.env.SESSION_COOKIE_PATH as string,
        sameSite: process.env.SESSION_COOKIE_SAMESITE as 'lax' | 'strict' | 'none', // boolean | 'lax' | 'strict' | 'none'
        secure: (process.env.SESSION_COOKIE_SECURE.toLowerCase() === 'true') as boolean, // boolean | 'auto'
    },

    // Streaming redirect criteria to accept a media file download by streaming.
    STREAM_REDIRECT_CRITERIA: {
        mimeTypeArr: [
            'audio/mp4',
            'audio/mpeg',
            'audio/x-m4a',
            'video/mp4',
        ] as string[],
        minFileSize: parseInt(process.env.STREAM_FILESIZE_MIN, 10) as number,
        redirectUri: process.env.STREAM_REDIRECT_URI as string,
    },

    // Streaming service status request to verify a media file streaming capability.
    STREAM_STATUS_REQUEST: {
        host: process.env.STREAM_STATUS_HOST as string,
        path: process.env.STREAM_STATUS_PATH as string,
    }
}
