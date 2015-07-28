var app = angular.module('HatenaApp', ['ngMaterial']);

app.controller('AppCtrl', ['$scope', '$mdSidenav', '$mdDialog', function($scope, $mdSidenav, $mdDialog) {
  $scope.protocol = {
    get: true,
    post: true
  };
  $scope.path = '';
  $scope.user = '';
  $scope.myFilter = function(log) {
    return (($scope.protocol.get && log.protocol === 'GET') || ($scope.protocol.post && log.protocol === 'POST')) &&
      (!$scope.path || ~log.path.indexOf($scope.path)) &&
      (!$scope.user || ~log.user.indexOf($scope.user));
  };
  $scope.myOrder = 'user'
  $mdDialog.show({
      controller: function($scope, $mdDialog) {
        $scope.answer = function(answer) {
          $mdDialog.hide(parseLTSVLog($scope.log));
        };
      },
      templateUrl: 'dialog.html',
      parent: angular.element(document.body)
    })
    .then(function(answer) {
      answer.forEach(function(item) {
        if (item.req) {
        var temp = item.req.split(' ');
        item.protocol = temp[0];
        item.path = temp[1];
        }
      });
      $scope.logs = answer;
    }, function() {});
}]);
