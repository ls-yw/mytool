export const wordRouter = [
    {
        path: '/word/length',
        name: 'wordLength',
        component: () => import('@/views/word/length'),
        meta:{
            title:'统计字符串长度'
        }
    }
]
