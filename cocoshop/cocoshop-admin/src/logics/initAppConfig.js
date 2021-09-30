
import { useLocaleStore } from '/@/store/modules/locale';

export function initAppConfigStore() {
    const localeStore = useLocaleStore();

    localeStore.initLocale();
}