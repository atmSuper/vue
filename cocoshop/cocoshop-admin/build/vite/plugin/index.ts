import type { Plugin } from 'vite';

import vue from '@vitejs/plugin-vue';
import { configStyleImportPlugin } from './styleImport'
import { configSvgIconsPlugin } from './svgSprite'
export function createVitePlugins() {

    const vitePlugins: (Plugin | Plugin[])[] = [
        // have to
        vue(),
        // have to
    ];

    vitePlugins.push(configStyleImportPlugin(true));

    vitePlugins.push(configSvgIconsPlugin(true));

    return vitePlugins;

}
