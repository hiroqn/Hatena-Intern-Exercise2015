// 課題 JS-3 の実装をここに記述してください。
document.addEventListener('DOMContentLoaded', function (e) {
    document.getElementById('submit-button').addEventListener('click', function (e) {
      createLogTable(document.getElementById('table-container'), parseLTSVLog(document.getElementById('log-input').value));
    })
});
