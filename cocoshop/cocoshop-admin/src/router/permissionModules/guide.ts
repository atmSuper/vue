import { RouteRecordRaw } from 'vue-router'
import Layout from '/@/layout/index.vue'

const GuideRouter: Array<RouteRecordRaw> = [
  {
    path: '/guide',
    component: Layout,
    children: [
      {
        path: 'index',
        component: () => import('/@/views/guide/index.vue'),
        name: 'Guide',
        meta: {
          title: 'guide',
          icon: 'dashboard'
        }
      }
    ]
  }
]

export default GuideRouter
