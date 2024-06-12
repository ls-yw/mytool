export const travelRouter = [
    {
        path: '/travel/guideMap',
        name: 'travelGuideMap',
        component: () => import('@/views/travel/guide/map'),
        meta:{
            title:'攻略地图'
        }
    }
]
