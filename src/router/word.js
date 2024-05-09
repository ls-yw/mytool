export const wordRouter = [
    {
        path: '/word/length',
        name: 'wordLength',
        component: () => import('@/views/word/length'),
        meta:{
            title:'统计字符串长度'
        }
    },
    {
        path: '/word/special',
        name: 'wordSpecial',
        component: () => import('@/views/word/special'),
        meta:{
            title:'特殊字符'
        }
    }
]
