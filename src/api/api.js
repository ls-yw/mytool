import http from "@/utils/http";

export const getCurl =(url) => {
    return http({
        method: 'get',
        url,
    })
}

export const postCurl =(url, data) => {
    return http({
        method: 'post',
        url,
        data
    })
}
