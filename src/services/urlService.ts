export async function aoeFileDownloadUrl(key: string) {
    return (!key) ? undefined : process.env.FILE_DOWNLOAD_URL + key;
}

export async function aoeThumbnailDownloadUrl(id: string) {
    return (!id) ? undefined : process.env.THUMBNAIL_DOWNLOAD_URL + id;
}