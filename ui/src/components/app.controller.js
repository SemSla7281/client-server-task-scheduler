angular.module('Scheduler').controller('AppController', ['$rootScope', '$scope', '$state',
  function($rootScope, $scope, $state) {
    if (!$scope.code) {
      $state.go('tasks');
    }

    $rootScope.$on('InternalServerError', function (event, data) {
      $scope.code = 500;
      $scope.content = 'We are sorry but something went wrong!';

      $state.go('httpError');
    });

    $rootScope.$on('NotFound', function (event, data) {
      $scope.code = 404;
      $scope.content = 'The resource you are looking for does not exist!';

      $state.go('httpError');
    });

    $rootScope.$on('HttpError', function (event, data) {
      $scope.code = data.code;
      $scope.content = 'We are unable to reach our servers at the moment! Please try again after some time.';

      $state.go('httpError');
    });
  }
]);
