import { createStore, createLogger } from 'vuex';


import { store as app, AppStore, AppState } from '/@/vux/modules/app'
import { store as settings, SettingStore, SettingsState } from '/@/vux/modules/settings'
import { store as permission, PermissionStore, PermissionState } from '/@/vux/modules/permission'
import { store as tagViews, TagsStore, TagsViewState } from '/@/vux/modules/tagsview'
export interface RootState {
    app: AppState,
    settings: SettingsState,
    permission: PermissionState,
    tagViews: TagsViewState
}
export type Store = AppStore<Pick<RootState, 'app'>>  & SettingStore<Pick<RootState, 'settings'>>
& PermissionStore<Pick<RootState, 'permission'>> & TagsStore<Pick<RootState, 'tagViews'>>

const debug = process.env.NODE_ENV !== 'production'
const plugins = debug ? [createLogger({})] : []

export const store = createStore({
    plugins,
    modules: {
      app,
      settings,
      permission,
      tagViews
    }
})
export function useStore(): Store {
    return store as Store
}
  