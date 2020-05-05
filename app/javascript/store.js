import Vue from "vue";
import Vuex from 'vuex'
import $http from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    items: [],
    item: {
      polygon: []
    },
    page: 1,
    total: 1,
    message: null,
    perPage: 10,
  },
  getters:{
    getItems(state){
      return state.items
    },
    getItem(state){
      return state.item
    },
    getPerPage(state){
      return Number(state.perPage)
    },
    getPage(state){
      return Number(state.page)
    },
    getTotal(state){
      return Number(state.total) * state.perPage
    },
  },
  actions:{
    Alert({commit},errors){
      commit("SET", { type: "message", items: errors });
    },
    SetPage({ commit }, item ){
      commit('SET', { type: 'page', items: Number( item ) })
    },
    List({ commit,getters,dispatch }){
      const params = { page: getters.getPage }
      return new Promise((resolve, reject) => {
        $http.get(`/tickets`,{params:params}).then(response => {
          if(response.data.success){
            commit('SET', {type: 'items', items: response.data.items })
            commit('SET', {type: 'total', items: response.data.total })
          }
          else{
            commit('SET', {type: 'items', items: [] })
            commit('SET', {type: 'total', items: 1 })
            dispatch('Alert', response.data.errors )
          }
          resolve(response.data);
        }, error => {
            reject(error);
          }
        ).catch(err => console.log(err.response))
      })
    },
    Show({ commit,dispatch }, id){
      return new Promise((resolve, reject) => {
        $http.get(`/tickets/${id}`).then(response => {
          if(response.data.success){
            commit('SET', {type: 'item', items: response.data.item })
          }
          else{
            commit('SET', {type: 'item', items: {} })
            dispatch('Alert', response.data.errors )
          }
          resolve(response.data);
        }, error => {
            reject(error);
          }
        ).catch(err => console.log(err.response))
      })

    },
  },

  mutations: {
    SET(state, {type,items}) {
      state[type] = items
    }
  }
})

export default store


