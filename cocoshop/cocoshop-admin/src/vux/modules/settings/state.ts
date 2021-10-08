
import layoutSettings from '/@/config/default/layout'

export interface SettingsState {
    showTagsView:boolean
    showSidebarLogo: boolean
    fixedHeader:boolean
}

export const state: SettingsState = {
    showTagsView:layoutSettings.showTagsView,
    showSidebarLogo: layoutSettings.showSidebarLogo,
    fixedHeader:layoutSettings.fixedHeader
}