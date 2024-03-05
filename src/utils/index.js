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
  const dateList = [];
  let currentDate = new Date(startDate);

  while (currentDate <= new Date(endDate)) {
    const month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
    const day = currentDate.getDate().toString().padStart(2, '0');

    dateList.push(`${month}-${day}`);
    // dateList.push(currentDate.toISOString().split('T')[0]); // 格式化日期为 'YYYY-MM-DD'
    currentDate.setDate(currentDate.getDate() + 1);
  }

  return dateList;
}
