import Vue from 'vue'
import Router from 'vue-router'

// in development-env not use lazy-loading, because lazy-loading too many pages will cause webpack hot update too slow. so only in production use lazy-loading;
// detail: https://panjiachen.github.io/vue-element-admin-site/#/lazy-loading

Vue.use(Router)

/* Layout */
import Layout from '../views/layout/Layout'

/**
 * hidden: true                   if `hidden:true` will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu, whatever its child routes length
 *                                if not set alwaysShow, only more than one route under the children
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noredirect           if `redirect:noredirect` will no redirct in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    title: 'title'               the name show in submenu and breadcrumb (recommend set)
    icon: 'svg-name'             the icon show in the sidebar,
  }
 **/
export const constantRouterMap = [
  {path: '/login', component: () => import('@/views/login/index'), hidden: true},
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    name: 'dashboard',
    hidden: false,
    children: [{
      path: 'dashboard',
      component: () => import('@/views/dashboard/index'),
      meta: {title: 'dashboard', icon: 'dashboard', noCache: true}
    },
      {
        path: '/account/profile',
        name: '个人资料',
        component: () => import('@/views/account/profile.vue'),
        hidden: true,
        meta: {title: '个人资料'}

      },
      {
        path: '/account/timeline',
        name: '最近活动',
        component: () => import('@/views/account/timeline.vue'),
        hidden: true,
        meta: {title: '最近活动'}

      },
      {
        path: '/account/updatePwd',
        name: '修改密码',
        component: () => import('@/views/account/updatePwd.vue'),
        hidden: true,
        meta: {title: '修改密码'}

      }
    ]
  },
  // {
  //   path: '/data',
  //   component: Layout,
  //   redirect: '#',
  //   name: 'data',
  //   alwaysShow: true,
  //   meta: {
  //     roles: ['administrator', 'developer'],
  //     title: '业务管理',
  //     icon: 'shopping'
  //   },
  //   children: [
  //     {
  //       path: 'shop',
  //       name: 'shop',
  //       component: () => import('@/views/business/shop/index'),
  //       meta: { title: '商铺管理' }
  //     },
  //     {
  //       path: 'food',
  //       name: 'food',
  //       component: () => import('@/views/business/food/index'),
  //       meta: { title: '食品管理' }
  //     },
  //     {
  //       path: 'order',
  //       name: 'order',
  //       component: () => import('@/views/business/order/index'),
  //       meta: { title: '订单管理' }
  //     },
  //     {
  //       path: 'shop/add',
  //       name: 'shop_add',
  //       component: () => import('@/views/business/shop/add.vue'),
  //       meta: { title: '添加商铺' }
  //     },
  //     {
  //       path: 'food/add',
  //       name: 'food_add',
  //       component: () => import('@/views/business/food/add.vue'),
  //       meta: { title: '添加食品' }
  //     }
  //   ]
  // },
  {path: '/404', component: () => import('@/views/404'), hidden: true}

]

export default new Router({
  // mode: 'history', //后端支持可开
  scrollBehavior: () => ({y: 0}),
  routes: constantRouterMap
})

export const asyncRouterMap = [
  {
    path: '/business',
    component: Layout,
    redirect: '#',
    name: 'Bussiness',
    alwaysShow: true,
    meta: {
      // roles: ['administrator'],
      title: 'businessMgr',
      icon: 'shopping'
    },
    children: [

      {
        path: 'sdetail',
        name: 'sdetail',
        component: () => import('@/views/business/sdetail/index'),
        meta: {title: 'sdetail'}
      },
      {
        path: 'shop/add',
        name: 'shop_add',
        component: () => import('@/views/business/shop/add.vue'),
        meta: {title: '添加商铺'}
      },
      {
        path: 'shop',
        name: 'shop',
        component: () => import('@/views/business/shop/index'),
        meta: {title: 'shopMgr'}
      },

      {
        path: 'food',
        name: 'food',
        component: () => import('@/views/business/food/index'),
        meta: {title: 'foodMgr'}
      },
      {
        path: 'order',
        name: 'order',
        component: () => import('@/views/business/order/index'),
        meta: {title: 'orderMgr'}
      },
      {
        path: 'orderdetail',
        name: 'orderdetail',
        hidden:true,
        component: () => import('@/views/business/orderdetail/index'),
        meta: {title: '订单详情'}
      },

      {
        path: 'food/add',
        name: 'food_add',
        hidden: true,
        component: () => import('@/views/business/food/add.vue'),
        meta: {title: '添加食品'}
      }
    ]
  },
  {
    path: '/system',
    component: Layout,
    redirect: '#',
    name: 'System',
    alwaysShow: true,
    meta: {
      roles: ['administrator'],
      title: 'systemMgr',
      icon: 'edit'
    },
    children: [
      {
        path: 'menu',
        name: 'Menu',
        component: () => import('@/views/system/menu/index'),
        meta: {
          title: 'menuMgr'
        }
      },
      {
        path: 'dept',
        name: 'Department',
        component: () => import('@/views/system/dept/index'),
        meta: {
          title: 'deptMgr'
        }
      },
      {
        path: 'mgr',
        name: 'Account',
        component: () => import('@/views/system/user/index'),
        meta: {title: 'userMgr'}
      },
      {
        path: 'role',
        name: 'roleMgr',
        component: () => import('@/views/system/role/index'),
        meta: {title: 'roleMgr'}
      },
      {
        path: 'task',
        name: 'Task',
        component: () => import('@/views/system/task/index'),
        meta: {title: 'taskMgr'}
      },
      {
        path: 'taskLog',
        name: 'taskLog',
        component: () => import('@/views/system/task/taskLog.vue'),
        hidden: true,
        meta: {title: 'taskLog'}

      },
      {
        path: 'dict',
        name: 'Dict',
        component: () => import('@/views/system/dict/index'),
        meta: {title: 'dictMgr'}
      },
      {
        path: 'cfg',
        name: 'Config',
        component: () => import('@/views/system/cfg/index'),
        meta: {
          title: 'configMgr'
        }
      }
    ]
  },

  {
    path: '/optionMgr',
    component: Layout,
    redirect: '#',
    name: 'optionMgr',
    alwaysShow: true,
    meta: {
      roles: ['administrator', 'developer'],
      title: 'optionMgr',
      icon: 'example'
    },
    children: [
      {
        path: 'druid',
        name: 'druid',
        component: () => import('@/views/operation/druid/index'),
        meta: {title: 'druid'}
      },
      {
        path: 'swagger',
        name: 'swagger',
        component: () => import('@/views/operation/api/index'),
        meta: {title: 'swagger'}
      },
      {
        path: 'loginLog',
        name: 'Login Log',
        component: () => import('@/views/system/loginLog/index'),
        meta: {title: 'loginLog'}
      },
      {
        path: 'log',
        name: 'Bussiness Log',
        component: () => import('@/views/system/log/index'),
        meta: {title: 'bussinessLog'}
      }
    ]
  },
  {
    path: '/message',
    component: Layout,
    redirect: '#',
    name: 'messageMgr',
    alwaysShow: true,
    meta: {
      roles: ['administrator', 'developer'],
      title: 'messageMgr',
      icon: 'message'
    },
    children: [
      {
        path: 'history',
        name: 'message',
        component: () => import('@/views/message/message/index'),
        meta: {title: 'historyMessage'}
      },
      {
        path: 'template',
        name: 'template',
        component: () => import('@/views/message/template/index'),
        meta: {title: 'messageTemplate'}
      },
      {
        path: 'sender',
        name: 'Message Sender',
        component: () => import('@/views/message/sender/index'),
        meta: {title: 'messageSender'}
      }
    ]
  },
  {path: '/404', component: () => import('@/views/404'), hidden: true}
]

