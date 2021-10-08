import type { LocaleSetting, LocaleType , SideBar} from '/#/config';
import { defineStore } from "pinia";
import { store } from "/@/store";

import { createLocalStorage } from "/@/utils/cache";
import { localeSetting } from '/@/settings/localeSetting';
import { LOCALE_KEY } from '/@/enums/cacheEnum';

const ls = createLocalStorage()

const lsLocaleSetting = (ls.get(LOCALE_KEY) || localeSetting) as LocaleSetting;

interface LocaleState {
   localInfo: LocaleSetting;
   sidebar: SideBar
 }
// Partial 两个属性都变为可选,可以使用Partial类型进行转换
export const useLocaleStore = defineStore({
     id:'app-locale',
     state:():LocaleState => ({
        localInfo: lsLocaleSetting,
        sidebar:{
            opened:false,
            withoutAnimation: false
        }
     }),
     getters:{
        getLocale():LocaleType {
            return this.localInfo?.locale ?? 'zh_CN'
        },
        getSidebar():SideBar{
           return this.sidebar;
        }
     },
     actions:{
        setLocaleInfo(info:Partial<LocaleSetting>){
            this.localInfo = { ...this.localInfo, ...info };
            ls.set(LOCALE_KEY, this.localInfo);
        },
        setSidebar(info:Partial<SideBar>){
           this.sidebar = {...this.sidebar,...info};
        },
        initLocale(){
            this.setLocaleInfo({
               ...localeSetting,
               ...this.localInfo,
            })
        }
     }
})
export function useLocaleStoreWithOut() {
   return useLocaleStore(store);
 }