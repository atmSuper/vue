import type { LocaleType } from '/#/config';
import { i18n } from './setupI18n';
import { unref, computed } from 'vue';
import { useLocaleStoreWithOut } from '/@/store/modules/locale';
import { loadLocalePool, setHtmlPageLang } from './helper';
import { messages } from './index';

function setI18nLanguage(locale: LocaleType) {
    const localeStore = useLocaleStoreWithOut();
  
    if (i18n.mode === 'legacy') {
      i18n.global.locale = locale;
    } else {
      (i18n.global.locale as any).value = locale;
    }
    localeStore.setLocaleInfo({ locale });
  }


export function useLocale() {
    const localeStore = useLocaleStoreWithOut();
    const getLocale = computed(() => localeStore.getLocale);

    async function changeLocale(locale: LocaleType) {

        const globalI18n = i18n.global;
        const currentLocale = unref(globalI18n.locale);
        if (currentLocale === locale) {
          return locale;
        }
        if (loadLocalePool.includes(locale)) {
            setI18nLanguage(locale);
            return locale;
        }
        globalI18n.setLocaleMessage(locale,messages[locale]);
        
        loadLocalePool.push(locale);

        setI18nLanguage(locale);
        return locale;
    }
    return {
        getLocale,
        changeLocale
    }
}
