import { defineStore } from "pinia";
import { store } from "/@/store";
import { TOKEN_KEY } from '/@/enums/cacheEnum';
import { getAuthCache, setAuthCache } from '/@/utils/auth';

interface UserState{
  token?:string;
}

export const useUserStore = defineStore({
  id: 'app-user',
  state: (): UserState => ({
    token: undefined,
  }),
  getters:{
    getToken(): string {
        return this.token || getAuthCache<string>(TOKEN_KEY);
    },
  },
  actions: {
    setToken(token: string | undefined) {
        this.token = token;
        setAuthCache(TOKEN_KEY, token);
    },
  }
})

export function useUserStoreWithOut() {
    return useUserStore(store);
}