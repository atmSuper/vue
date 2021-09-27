
import { type } from 'os';
import { createStorage as create, CreateStorageParams } from './storageCache';
import { DEFAULT_CACHE_TIME } from '/@/settings/encryptionSetting';
import { enableStorageEncryption } from '/@/settings/encryptionSetting';
import { getStorageShortName } from '/@/utils/env';

export type Options = Partial<CreateStorageParams>;

const createOptions = (storage: Storage, options: Options = {}): Options => {
    return {
      // No encryption in debug mode
      hasEncrypt: enableStorageEncryption,
      storage,
      prefixKey: getStorageShortName(),
      ...options,
    };
};

export const createStorage = (storage: Storage = sessionStorage, options: Options = {}) => {
    return create(createOptions(storage, options));
};

export const createLocalStorage = (options: Options = {}) => {
    return createStorage(localStorage, { ...options, timeout: DEFAULT_CACHE_TIME });
};
  