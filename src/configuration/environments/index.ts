process.env.NODE_ENV = process.env.NODE_ENV || 'development';

export default {

    // Streaming redirect criteria
    STREAM_REDIRECT_CRITERIA: {
        mimeTypeArr: [
            'video/mp4'
        ] as string[],
        minFileSize: parseInt(process.env.STREAM_FILESIZE_MIN, 10) as number,
        redirectUri: process.env.STREAM_REDIRECT_URI as string
    }
}
