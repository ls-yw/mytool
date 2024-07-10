export function joinRequestData(data) {
  const requestSortData = []
  Object.keys(data).sort().map(key => {
    const dataType = typeof data[key]
    if (dataType !== 'object' && dataType !== 'array' && dataType !== 'undefined') {
      requestSortData.push(key + '=' + data[key])
    }
  })
  return requestSortData.join('&')
}

export function getDatesBetween(startDate, endDate) {
  const dateList = []
  const currentDate = new Date(startDate)

  while (currentDate <= new Date(endDate)) {
    const month = (currentDate.getMonth() + 1).toString().padStart(2, '0')
    const day = currentDate.getDate().toString().padStart(2, '0')

    dateList.push(`${month}-${day}`)
    // dateList.push(currentDate.toISOString().split('T')[0]); // 格式化日期为 'YYYY-MM-DD'
    currentDate.setDate(currentDate.getDate() + 1)
  }

  return dateList
}

export function randomWord(length = 32) { // 生成指定长度的随机数，默认32位
  // 由以下元素组成
  const arr = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
    'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ]
  let num = ''
  for (let i = 0; i < length; i++) {
    num += arr[parseInt(Math.random() * arr.length)]
  }
  return num
}
