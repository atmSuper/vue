import Axios from 'axios'
import { ElMessage } from 'element-plus'

const baseURL = 'http://localhost:8082'

const axios = Axios.create({
  baseURL,
  withCredentials: false, // send cookies when cross-domain requests
  timeout: 20000 //请求超时20秒
})

// 请求前的处理
axios.interceptors.request.use(
  (config) => {
    /**
     * 根据你的项目实际情况来对 config 做处理
     * 这里对 config 不做任何处理，直接返回
     */
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// 请求后的处理
axios.interceptors.response.use(
  (response) => {
    /**
     * 根据你的项目实际情况来对 config 做处理
     * 这里对 config 不做任何处理，直接返回
     */
    return response
  },
  (error) => {
    if (error.response && error.response.data) {
      const code = error.response.status
      const msg = error.response.data.message
      ElMessage.error(`Code: ${code}, Message: ${msg}`)
      console.error(`[Axios Error]`, error.response)
    } else {
      ElMessage.error(`${error}`)
    }
    return Promise.reject(error)
  }
)
export default axios
