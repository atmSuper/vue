import { createLocalStorage} from '/@/utils/cache';

import { Memory } from './memory';

import { DEFAULT_CACHE_TIME } from '/@/settings/encryptionSetting';

import { toRaw } from 'vue';

const localMemory = new Memory(DEFAULT_CACHE_TIME);

import {
    TOKEN_KEY,
    USER_INFO_KEY,
    ROLES_KEY,
    LOCK_INFO_KEY,
    PROJ_CFG_KEY,
    APP_LOCAL_CACHE_KEY,
    APP_SESSION_CACHE_KEY,
    MULTIPLE_TABS_KEY,
  } from '/@/enums/cacheEnum';

interface BasicStore {
    [TOKEN_KEY]: string | number | null | undefined;
}

type LocalStore = BasicStore;

type LocalKeys = keyof LocalStore;

const ls = createLocalStorage();

export type BasicKeys = keyof BasicStore;

export class Persistent {

    static getLocal<T>(key: LocalKeys) {
        return localMemory.get(key)?.value;
    }
    
    static setLocal(key: LocalKeys, value: LocalStore[LocalKeys], immediate = false): void {
        localMemory.set(key, toRaw(value));
        immediate && ls.set(APP_LOCAL_CACHE_KEY, localMemory.getCache);
    }
}