import { defineConfig } from 'vite';
import path from 'path';
import { resolve } from 'path';
import { createVitePlugins } from './build/vite/plugin/index'

function pathResolve(dir: string) {
  return resolve(process.cwd(), '.', dir);
}

export default defineConfig({
  resolve: {
    alias: [
      {
        find: 'vue-i18n',
        replacement: 'vue-i18n/dist/vue-i18n.cjs.js',
      },
      {
        find: /\/@\//,
        replacement: pathResolve('src') + '/',
      },
    ],
  },
  base: './', // 设置打包路径
  server: {
    port: 4000, // 设置服务启动端口号
    open: true, // 设置服务启动时是否自动打开浏览器
    cors: true,// 允许跨域

    // 设置代理，根据我们项目实际情况配置
    proxy: {
      '/dev-api': {
        target: 'http://localhost:8082',
        changeOrigin: true,
        secure: false,
        rewrite: (path) => path.replace('/dev-api', '/')
      }
    }
  },
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `
        @import "./src/styles/base/colors.scss";
        @import "./src/styles/base/class.scss";
       `
      }
    }
  },
  plugins:createVitePlugins()
});
