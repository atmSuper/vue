

import styleImport from 'vite-plugin-style-import';

export function configStyleImportPlugin(isBuild: boolean) {
    if(!isBuild) return [];
    const styleImportPlugin = styleImport({
        libs: [
          {
            libraryName: 'element-plus',
            resolveStyle: (name) => {
              return `element-plus/lib/theme-chalk/${name}.css`;
            },
            resolveComponent: (name) => {
              return `element-plus/lib/${name}`;
            }
          }
        ]
      })
    return styleImportPlugin;
}