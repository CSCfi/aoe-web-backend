export async function aoeFileDownloadUrl(key: string) {
    return (!key) ? undefined : process.env.FILE_DOWNLOAD_URL + key;
}