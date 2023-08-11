export {};

declare module 'multer' {
  type DestinationCallback = (error: Error | null, destination: string) => void;
  type FileNameCallback = (error: Error | null, filename: string) => void;
}
