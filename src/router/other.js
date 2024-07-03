export const otherRouter = [
  {
    path: '/other/music',
    name: 'otherMusic',
    component: () => import('@/views/other/music'),
    meta: {
      title: '音乐下载'
    }
  }
]
