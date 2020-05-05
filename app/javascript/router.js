import Vue from "vue";
import Router from "vue-router";
Vue.use(Router);
const router = new Router({
  routes: [
    {
      path: "/",
      name: "root",
      component: () => import("@views/main.vue"),
    },
    {
      path: "/list/:id",
      name: "item",
      props: true,
      component: () => import("@views/item.vue"),
    },
    {
      path: "/list",
      name: "list",
      component: () => import("@views/list.vue"),
    }
  ],
});
export default router