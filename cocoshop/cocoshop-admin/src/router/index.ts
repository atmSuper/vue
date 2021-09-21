import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router';

import Login from '@/views/login/login.vue';

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    component: Login
  },
];
const router = createRouter({
  history: createWebHashHistory(),
  routes
});
export default router;
