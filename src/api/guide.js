import request from '@/utils/request'

export const getGuideInfo = (params) => {
  return request({
    method: 'get',
    url: '/mytool/guideInfo',
    params
  })
}

export const saveGuide = (data) => {
  return request({
    method: 'post',
    url: '/mytool/saveGuide',
    data
  })
}
