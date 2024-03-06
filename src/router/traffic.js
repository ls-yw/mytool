export const trafficRouter = [
    {
        path: '/traffic/plane',
        name: 'plane',
        component: () => import('@/views/traffic/plane'),
        meta:{
            title:'机票查询'
        }
    }
]
