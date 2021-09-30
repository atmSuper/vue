import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router';

import Login from '/@/views/login/login.vue';
import Layout from '/@/layout/index.vue';
const routes: Array<RouteRecordRaw> = [
  {
    path: '/login',
    component: Login
  },
  {
    path: '/dashboard',
    component: Layout,
  },
];
const router = createRouter({
  history: createWebHashHistory(),
  routes
});
export default router;
