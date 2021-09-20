import { Store } from 'vuex'
import { IState } from './store'

declare module '@vue/runtime-core' {
  // 拓展Vuex
  interface ComponentCustomProperties {
    $store: Store<IState>
  }
}
