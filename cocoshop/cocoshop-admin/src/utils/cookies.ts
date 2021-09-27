import { Keys } from "/@/settings/langSetting"
import Cookies from 'js-cookie'

export const getLanguage = () => Cookies.get(Keys.languageKey)
export const setLanguage = (language: string) => Cookies.set(Keys.languageKey, language)
