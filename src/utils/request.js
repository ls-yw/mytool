import axios from 'axios'
import { joinRequestData } from '@/utils/index'
import md5 from 'md5'
import { Toast } from 'vant'

// create an axios instance
const service = axios.create({
  baseURL: process.env.VUE_APP_BASE_API, // url = base url + request url
  // withCredentials: true, // send cookies when cross-domain requests
  timeout: 5000 // request timeout
})

// request interceptor
service.interceptors.request.use(
  config => {
    // config.headers['timestamp'] = Date.now()
    const requestData = {
      ...config.data,
      ...config.params,
      // version: config.headers['version'],
      // timestamp: config.headers['timestamp']
    }
/*    const waitString = joinRequestData(requestData)
    config.headers['sign'] = md5(md5(waitString) + process.env.VUE_APP_ENCRYPT_SALT)
    let appletId = localStorage.getItem('AppletId')
    if (!appletId) {
      appletId = Date.now().toString() + (Math.floor(Math.random() * (9999999 - 1000000)) + 1000000)
        .toString()
      localStorage.setItem('AppletId', appletId)
    }
    config.headers['Applet-Id'] = appletId
    config.headers['token'] = ''
    config.headers['lat'] = ''
    config.headers['lon'] = ''
    config.headers['platform'] = 'h5'
    config.headers['channel'] = ''
    config.headers['version'] = process.env.VUE_APP_VERSION
    config.headers['merchant'] = '2o8p31mOtZVu1CTiWj5Z54N0jD0JI7lCw'
    config.headers['sid'] = ''*/
    return config
  },
  error => {
    // do something with request error
    console.log(error) // for debug
    return Promise.reject(error)
  }
)

// response interceptor
service.interceptors.response.use(
  /**
   * If you want to get http information such as headers or status
   * Please return  response => response
  */

  /**
   * Determine the request status by custom code
   * Here is just an example
   * You can also judge the status by HTTP Status Code
   */
  response => {
    const res = response.data

    // if the custom code is not 20000, it is judged as an error.
    if (res.code !== 0) {
      Toast.fail(res.msg || 'Error')

      // 50008: Illegal token; 50012: Other clients logged in; 50014: Token expired;
      if (res.code === 101) {
        Toast.fail('您未登录或登录信息已失效，请重新登录')
        // todo 删除token 跳转登录页面
      }
      return Promise.reject(new Error(res.msg || 'Error'))
    } else {
      return res
    }
  },
  error => {
    console.log('err' + error) // for debug
    Toast.fail(error.msg)
    return Promise.reject(error)
  }
)

export default service

