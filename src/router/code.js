export const codeRouter = [
    // {
    //     path: '/code',
    //     name: 'code',
    //     component: () => import('@/views/code/list')
    // },
    {
        path: '/code/timeConvert',
        name: 'timeConvert',
        component: () => import('@/views/code/timeConvert'),
        meta:{
            title:'时间戳转换'
        }
    }
]
