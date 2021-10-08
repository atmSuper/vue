
export type LocaleType = 'zh_CN' | 'en' | 'ru' | 'ja' | 'ko';

export interface LocaleSetting {
    showPicker: boolean;

    locale:LocaleType;

    fallback:LocaleType;

    availableLocales:LocaleType[];
}

export interface SideBar{

    opened:boolean;

    withoutAnimation: boolean;
}