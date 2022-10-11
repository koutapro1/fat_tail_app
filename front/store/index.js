import axios from "~/plugins/axios"

export const state = () => ({
  morphs: [],
})

export const getters = {
  morphs: state => state.morphs
}

export const mutations = {
  setMorphs(state, morphs) {
    state.morphs = morphs
  }
}

export const actions = {
  fetchMorphs({ commit }) {
    axios.get('morphs')
    .then(res => {
      commit('setMorphs', res.data)
    })
    .catch(err => console.log(err.response));
  }
}
