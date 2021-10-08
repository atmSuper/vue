import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router';

import Layout from '/@/layout/index.vue';

const constantFiles = import.meta.globEager('./constantModules/*.ts');
let constantModules: Array<RouteRecordRaw> = []

Object.keys(constantFiles).forEach((key) => {
  if (key === './index.ts') return
  constantModules = constantModules.concat(constantFiles[key].default)
})

const asyncFiles = import.meta.globEager('./permissionModules/*.ts');
let permissionModules: Array<RouteRecordRaw> = []
Object.keys(asyncFiles).forEach((key) => {
  if (key === './index.ts') return
  permissionModules = permissionModules.concat(asyncFiles[key].default)
})


export const constantRoutes: Array<RouteRecordRaw> =  [
  {
    path: '/redirect',
    component: Layout,
    meta: { hidden: true },
    children: [
      {
        path: '/redirect/:path(.*)',
        component: () => import('/@/views/redirect/Index.vue')
      }
    ]
  },
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        component: () => import('/@/views/dashboard/Index.vue'),
        name: 'Dashboard',
        meta: {
          title: 'dashboard',
          icon: 'dashboard',
          affix: true
        }
      }
    ]
  },
  ...constantModules,
];

export const asyncRoutes: Array<RouteRecordRaw> = [
  ...permissionModules
]

const router = createRouter({
  history: createWebHashHistory(),
  routes: constantRoutes
})
export default router;
