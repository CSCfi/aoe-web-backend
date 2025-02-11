import app from '@/app';
import server from '@/server';
import { describe, expect, test } from '@jest/globals';
import { pgp } from '@resource/postgresClient';
import clientRedis from '@resource/redisClient';
import request, { Response } from 'supertest';

describe('API endpoint tests for status.ts (root)', (): void => {
  afterAll(async (): Promise<void> => {
    await clientRedis.disconnect();
    pgp.end();
    server.close();
  });

  test('API endpoint should return 200 with HTML content type', async (): Promise<void> => {
    const res: Response = await request(app).get('/');
    expect(res.statusCode).toEqual(200);
    expect(res.headers['content-type']).toMatch(/html/);
    expect(res.text).toMatch(/Service operable: true/);
  });
});
