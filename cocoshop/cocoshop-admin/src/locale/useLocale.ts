import type { LocaleType } from '/#/config';
import { i18n } from './setupI18n';
import { unref, computed } from 'vue';


import { messages } from './index';

export function useLocale() {
    
    async function changeLocale(locale: LocaleType) {
        const globalI18n = i18n.global;
        const currentLocale = unref(globalI18n.locale);
        if (currentLocale === locale) {
          return locale;
        }
        globalI18n.setLocaleMessage(locale,messages[locale]);

        return locale;
    }
    return {
        changeLocale
    }
}
