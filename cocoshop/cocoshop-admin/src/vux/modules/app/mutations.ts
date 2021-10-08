

import { MutationTree } from 'vuex'
import { AppState, DeviceType } from './state'
import { AppMutationTypes } from './mutation-types'

export type Mutations<S = AppState> = {
    [AppMutationTypes.TOGGLE_SIDEBAR](state: S, withoutAnimation: boolean): void
    [AppMutationTypes.CLOSE_SIDEBAR](state: S, withoutAnimation: boolean): void
}

export const mutations: MutationTree<AppState> & Mutations = {
    [AppMutationTypes.TOGGLE_SIDEBAR](state: AppState, withoutAnimation: boolean) {
        state.sidebar.opened = !state.sidebar.opened
        state.sidebar.withoutAnimation = withoutAnimation
        // if (state.sidebar.opened) {
        //   setSidebarStatus('opened')
        // } else {
        //   setSidebarStatus('closed')
        // }
    },
    [AppMutationTypes.CLOSE_SIDEBAR](state: AppState, withoutAnimation: boolean) {
        state.sidebar.opened = false
        state.sidebar.withoutAnimation = withoutAnimation
        // setSidebarStatus('closed')
    },
}