import { Persistent, BasicKeys } from '/@/utils/cache/persistent';
import { TOKEN_KEY } from '/@/enums/cacheEnum';


export function getToken() {
    return getAuthCache(TOKEN_KEY);
}

export function getAuthCache<T>(key: BasicKeys) {
    const fn = Persistent.getLocal ;
    return fn(key) as T;
}

export function setAuthCache(key: BasicKeys, value) {
    const fn = Persistent.setLocal;
    return fn(key, value, true);
}