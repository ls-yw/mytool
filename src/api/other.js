import request from '@/utils/request'

export const searchMusic = (params) => {
  return request({
    method: 'get',
    url: '/mytool/searchMusic',
    params
  })
}

export const downMusic = (params) => {
  return request({
    method: 'get',
    url: '/mytool/downMusic',
    params
  })
}
