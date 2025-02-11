import { hasExcludedAgents } from '@services/threadService';
import { describe, expect, test } from '@jest/globals';
import { Request } from 'express';

describe('Kafka thread function tests for threadService.ts', (): void => {
  test('Should return true when User-Agent includes "oersi" (case-insensitive)', async (): Promise<void> => {
    expect(
      hasExcludedAgents({
        headers: {
          'user-agent': 'OERSI-Import/0.1',
        },
      } as Request),
    ).toBe(true);
  });

  test('Should return false when User-Agent does not include "oersi" (case-insensitive)', async (): Promise<void> => {
    expect(
      hasExcludedAgents({
        headers: {
          'user-agent': 'PostmanRuntime/7.41.2',
        },
      } as Request),
    ).toBe(false);
  });
});
