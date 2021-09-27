import type { LocaleType, LocaleSetting } from "/#/config";

export const LOCALE: {[key:string]:LocaleType} = {
    ZH_CN:'zh_CN',
    EN_US:"en"
}

export const localeSetting:LocaleSetting = {
    showPicker:true,
    // Locale
    locale:LOCALE.ZH_CN,
    // default Locale
    fallback:LOCALE.ZH_CN,
    // available locales
    availableLocales:[LOCALE.ZH_CN,LOCALE.EN_US]
}