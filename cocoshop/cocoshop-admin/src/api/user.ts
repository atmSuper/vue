import Abstract from '/@/utils/http/abstract';
import axios  from '/@/utils/axios';
// class Basic extends Abstract {
//     authLogin(data) {
//         return this.postReq({ url: '/account/login', data });
//     }
// }

// let instance;
// export default (() => {
//     if (instance) return instance;
//     instance = new Basic();
//     return instance;
// })();

export function login(data) {
    return axios({
      url: '/account/login',
      method: 'post',
      params: {
        "username": data.username,
        "password": data.password
      }
    })
  }