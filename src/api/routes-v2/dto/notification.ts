export default class Notification {
  public notification: string;
  public updated: string;

  constructor(notification: string) {
    this.notification = notification;
    this.updated = new Date().toISOString();
  }
}
