export const cryptRouter = [
    {
        path: '/crypt/generatePwd',
        name: 'generatePwd',
        component: () => import('@/views/crypt/generatePwd'),
        meta:{
            title:'生成密码'
        }
    }
]
