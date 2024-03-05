import request from "@/utils/request";

export const getPlaneRegionApi = () => {
    return request({
        method: 'get',
        url: '/mytool/planeRegion',
    })
}

export const getPlaneRegionBySearchApi = (data) => {
    return request({
        method: 'post',
        url: '/mytool/planeRegionBySearch',
        data
    })
}
