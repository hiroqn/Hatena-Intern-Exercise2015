// 課題 JS-1: 関数 `parseLTSVLog` を記述してください

// 課題 JS-2: 関数 `createLogTable` を記述してください

function parseLTSVLog (logStr) {
  function typeConverter (key, value) {
    switch (key) {
      case 'epoch':
        return value - 0;
        break;
      default:
        return value;
        break;
    }
  }
  return logStr.split('\n').filter(function (lineStr) {
    return lineStr.length > 0;
  }).map(function (lineStr) {
    return lineStr.split('\t').reduce(function (prev, elemStr) {
      var temp = elemStr.split(':');
      prev[temp[0]] = typeConverter(temp[0], temp.slice(1).join(':'));
      return prev;
    }, {});
  });
}

function createLogTable (elem, logObj) {
  elem.innerHTML = [
    '<table>',
    '<thead><tr><th>path</th><th>epoch</th></tr></thead>',
    '<tbody>',
    logObj.map(function (obj) {
      return ['<tr><td>', obj.path, '</td><td>',obj.epoch ,'</td></tr>'].join('')
    }).join(''),
    '</tbody>',
    '</table>'
  ].join('');
  return elem;
}
