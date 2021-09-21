import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
// import "ant-design-vue/dist/antd.css";
import '@/icons' // icon
import '@/styles/index.scss' 
import importUiFramework from './utils/import-ui-framework'
import 'element-plus/lib/theme-chalk/index.css';

import { registerGlobComp } from './components/registerGlobComp';
// const app = createApp(App)
// app.use(router).use(store).mount('#app')


async function bootstrap() {
    const app = createApp(App);
    registerGlobComp(app)
    app.use(router).use(store).mount('#app')
}
void bootstrap();