import request from '@/utils/request'

export const searchMusic = (params) => {
  return request({
    method: 'get',
    url: '/mytool/searchMusic',
    params
  })
}

export const downMusic = (params) => {
  // return request({
  //   method: 'get',
  //   url: '/mytool/downMusic',
  //   params
  // })
  const keyValuePairs = Object.keys(params).map(key => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`)
  const args = keyValuePairs.join('&')
  return process.env.VUE_APP_BASE_API + '/mytool/downMusic' + '?' + args
}
