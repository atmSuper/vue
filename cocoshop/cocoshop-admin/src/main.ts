import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { setupStore } from '/@/store'
// import store from './store'
// import "ant-design-vue/dist/antd.css";
// import '@/icons' // icon
// 注册 svg icon
import 'vite-plugin-svg-icons/register';
// import '/@/assets/iconfont/iconfont.css'
import '/@/styles/index.scss' 
import importUiFramework from './utils/import-ui-framework'
import 'element-plus/lib/theme-chalk/index.css';

import { registerGlobComp } from '/@/components/registerGlobComp';

import { initAppConfigStore }from '/@/logics/initAppConfig';

import { store } from '/@/vux'



// import { i18n } from '/@/lang/index'
import { setupI18n } from "/@/locale/setupI18n"

import '/@/permission'
// const app = createApp(App)
// app.use(router).use(store).mount('#app')

// console.log(NUM)
async function bootstrap() {

    const app = createApp(App);
    
    setupStore(app)
    
    initAppConfigStore()
    
    await setupI18n(app)

    registerGlobComp(app)

    app.use(store).use(router).mount('#app')
}
void bootstrap();