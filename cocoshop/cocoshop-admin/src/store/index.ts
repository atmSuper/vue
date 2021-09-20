import { createStore } from 'vuex'

const defaultState = {
  count: 250
}

export type IState = typeof defaultState

const store = createStore<IState>({
  strict: true,
  state() {
    return defaultState
  },
  getters: {
    double(state) {
      return state.count * 2
    }
  },
  mutations: {
    increment(state, payload) {
      state.count++
    }
  },
  actions: {
    increment({ commit, state }, payload) {
      commit('increment', payload)
    }
  }
})
export default store
