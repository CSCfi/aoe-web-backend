// import app from '@/app';
import server from '@/server';
import { describe, expect, test } from '@jest/globals';
import { pgp } from '@resource/postgresClient';
import clientRedis from '@resource/redisClient';
// import request, { Response } from 'supertest';

describe('Unit tests for the metadata modifier functions', (): void => {
  afterAll(async (): Promise<void> => {
    await clientRedis.disconnect();
    pgp.end();
    server.close();
  });

  test('It works!', async (): Promise<void> => {
    expect(true);
  });
});
