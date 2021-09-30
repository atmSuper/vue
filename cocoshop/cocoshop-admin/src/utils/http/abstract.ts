import { AxiosRequest, CustomResponse } from './type';
import instance from './intercept';
import getUrl from './config';
class Abstract {
    protected baseURL: string = '/dev-api';

    // protected headers: object = {
    //     ContentType: 'application/x-www-form-urlencoded'
    // }
    

    private apiAxios({ baseURL = this.baseURL, headers, method, url, data, params, responseType }: AxiosRequest): Promise<CustomResponse> {
        // Object.assign(headers, {
        // });
         
         // url解析   
        //  const _url = (url as string).split('.');
        //  url = getUrl(_url[0], _url[1]);
        
        return new Promise((resolve, reject) => {
            instance({
                baseURL,
                headers,
                method,
                url,
                params,
                data,
                responseType
            }).then((res)=>{
                 // 200:服务端业务处理正常结束
                 if (res.status === 200) {
                    if (res.data.success) {
                        resolve({ status: true, message: 'success', data: res.data?.data, origin: res.data });
                    } else {
                        // Vue.prototype.$message({ type: 'error', message: res.data?.errorMessage || (url + '请求失败') });
                        resolve({ status: false, message: res.data?.errorMessage || (url + '请求失败'), data: res.data?.data, origin: res.data });
                    }
                } else {
                    resolve({ status: false, message: res.data?.errorMessage || (url + '请求失败'), data: null });
                }
            }).catch((err) => {
                const message = err?.data?.errorMessage || err?.message || (url + '请求失败');
                // Vue.prototype.$toast({ message });
                // eslint-disable-next-line
                reject({ status: false, message, data: null});
            });
        })
    
   }
   /**
     * GET类型的网络请求
     */
    protected getReq({ baseURL, headers, url, data, params, responseType }: AxiosRequest) {
        return this.apiAxios({ baseURL, headers, method: 'GET', url, data, params, responseType });
    }

    /**
     * POST类型的网络请求
     */
    protected postReq({ baseURL, headers, url, data, params, responseType }: AxiosRequest) {
        return this.apiAxios({ baseURL, headers, method: 'POST', url, data, params, responseType });
    }

    /**
     * PUT类型的网络请求
     */
    protected putReq({ baseURL, headers, url, data, params, responseType }: AxiosRequest) {
        return this.apiAxios({ baseURL, headers, method: 'PUT', url, data, params, responseType });
    }

    /**
     * DELETE类型的网络请求
     */
    protected deleteReq({ baseURL, headers, url, data, params, responseType }: AxiosRequest) {
        return this.apiAxios({ baseURL, headers, method: 'DELETE', url, data, params, responseType });
    }
}
export default Abstract;