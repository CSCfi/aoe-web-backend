export default class Notification {
    public notification;
    public updated;

    constructor(notification: string) {
        this.notification = notification;
        this.updated = new Date().toISOString();
    }
}
