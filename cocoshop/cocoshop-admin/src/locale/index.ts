import elementEnLocale from 'element-plus/lib/locale/lang/en'
import elementZhLocale from 'element-plus/lib/locale/lang/zh-cn'
// 导入自定义语言包
import enLocale from './en'
import zhLocale from './zh'

export const messages = {
  'en': {
    ...enLocale,
    ...elementEnLocale
  },
  'zh_CN': {
    ...zhLocale,
    ...elementZhLocale
  }
}