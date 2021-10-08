
import { ActionTree, ActionContext } from 'vuex'

// eslint-disable-next-line import/no-cycle
import { RootState } from '/@/vux'
import { AppState, DeviceType } from './state'
import { Mutations } from './mutations'
import { AppMutationTypes } from './mutation-types'
import { AppActionTypes } from './action-types'

type AugmentedActionContext = {
    commit<K extends keyof Mutations>(
      key: K,
      payload: Parameters<Mutations[K]>[1],
    ): ReturnType<Mutations[K]>
  } & Omit<ActionContext<AppState, RootState>, 'commit'>


  export interface Actions{
    [AppActionTypes.ACTION_TOGGLE_SIDEBAR](
        { commit }: AugmentedActionContext,
        withoutAnimation: boolean
      ): void
    [AppActionTypes.ACTION_CLOSE_SIDEBAR](
    { commit }: AugmentedActionContext,
    withoutAnimation: boolean
    ): void
  }
  export const actions: ActionTree<AppState, RootState> & Actions = {
    [AppActionTypes.ACTION_TOGGLE_SIDEBAR]({ commit }, withoutAnimation: boolean) {
        commit(AppMutationTypes.TOGGLE_SIDEBAR, withoutAnimation)
    },
    [AppActionTypes.ACTION_CLOSE_SIDEBAR]({ commit }, withoutAnimation: boolean) {
        commit(AppMutationTypes.CLOSE_SIDEBAR, withoutAnimation)
    },
  }
