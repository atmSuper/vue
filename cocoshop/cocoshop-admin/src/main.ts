import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import importUiFramework from './utils/import-ui-framework'
const app = createApp(App)
importUiFramework(app).use(router).use(store).mount('#app')
