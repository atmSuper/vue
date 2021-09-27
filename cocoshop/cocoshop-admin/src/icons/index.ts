// 引入文件
// webpack 用法
// const req = require.context('./svg', false, /\.svg$/)
// const requireAll = requireContext => requireContext.keys().map(requireContext)
// requireAll(req) webpack 用法
import { isEmpty } from '/@/utils/is'
const req = import.meta.globEager('./svg/*.svg') 
const requireAll = (requireContext:object) => {
    Object.keys(requireContext).forEach((key)=>{
        const mod = req[key].default || {};
        if(!isEmpty(mod)) return mod
    })
} 
requireAll(req);