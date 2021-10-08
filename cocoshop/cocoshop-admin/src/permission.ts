
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'

import router from '/@/router'
import { RouteLocationNormalized } from 'vue-router'
import { useStore } from '/@/vux'
import { PermissionActionType } from '/@/vux/modules/permission/action-types'
import { ElMessage } from 'element-plus'

NProgress.configure({ showSpinner: false })
const store = useStore()
store.dispatch(PermissionActionType.ACTION_SET_ROUTES, ["admin"])
store.state.permission.dynamicRoutes.forEach((route) => {
    router.addRoute(route)
})