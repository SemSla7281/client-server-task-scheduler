angular.module('Scheduler', [
  'ngAnimate', 'ui.router', 'ui.bootstrap', 'ngMaterial', 'angular-spinkit', 'toastr',
  'angularjs-datetime-picker', 'angularjs-dropdown-multiselect'
  ]
).run(['$rootScope', '$state', function($rootScope, $state) {
}])
.constant("config", {
  "apiBase": "http://localhost:3000/api"
})
.config(['$httpProvider', function($httpProvider) { $httpProvider.interceptors.push('loader'); }])
.config(['$mdDateLocaleProvider', function($mdDateLocaleProvider) {
  $mdDateLocaleProvider.formatDate = function(date) {
    return date ? moment(date).format('DD-MM-YYYY') : '';
  };

  $mdDateLocaleProvider.parseDate = function(dateString) {
    var m = moment(dateString, 'DD-MM-YYYY', true);
    return m.isValid() ? m.toDate() : new Date(NaN);
  };
}]);

angular.module('Scheduler').config(
  ['$stateProvider', '$urlRouterProvider', '$locationProvider',
    function($stateProvider, $urlRouterProvider, $locationProvider) {
      'use strict';

      $stateProvider
        .state('tasks', {
          url: '/tasks',
          templateUrl: 'src/components/tasks/main.html',
          controller: 'TaskController as taskCtrl'
        })
        .state('httpError', {
          url: '/httpError',
          templateUrl: 'src/shared/templates/httpError.html',
          controller: "AppController as appCtrl"
        });

      $urlRouterProvider.otherwise('/tasks');
    }
  ]);

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

angular.module('Scheduler').factory('loader', ['$q', '$rootScope', function($q, $rootScope) {
  var api_url_prefix = '/api';
  var request_count = 0;
  var response_count = 0;

  return {
    request: function(config) {
      $rootScope.showUi = false;
      request_count += 1;

      return config;
    },

    response: function(result) {
      var url = result.config.url;
      response_count += 1;

      if (response_count === request_count) {
        $rootScope.showUi = true;
      }

      return result;
    },

    responseError: function(rejection) {
      response_count += 1;
      $rootScope.showUi = true;

      switch (rejection.status) {
        case 500:
          $rootScope.$broadcast('InternalServerError');
          break;
        case 400:
          $rootScope.$broadcast('BadRequest', rejection.data.errors);
          break;
        case 404:
          $rootScope.$broadcast('NotFound', rejection.data.errors);
          break;
        default:
          $rootScope.$broadcast('HttpError', { code: rejection.status });
          break;
      }

      return $q.reject(rejection);
    }
  };
}]);

angular.module('Scheduler')
  .controller('TaskController', ['TaskService', '$scope', '$state', 'toastr',
    function(TaskService, $scope, $state, toastr) {
      var self = this;

      var metadata = TaskService.get_metadata();
      self.title = metadata.title;
      self.template = 'list';

      self.statusLabel = function(status) {
        return metadata.statusLabel[status];
      };

      var tasksIndex = function() {
        TaskService.index().then(function(response) {
          self.rows = response.data.payload;
          self.template = 'list';
          self.weekdays = response.data.meta.weekdays;
          self.agents = response.data.meta.agents;
        }, function(error) {
          self.rows = [];
          var msg = (error.data.errors.message == 'No Data Found' ? 'No data found' : 'Failed to fetch the data.');
          toastr.error(msg, 'Error!');
        });
      };

      self.new = function() {
        self.editing = {};
        self.template = 'edit';
      };

      self.edit = function(task) {
        self.editing = task;
        self.template = 'edit';
      };

      self.create = function() {
        TaskService.create(self.editing).then(function(response) {
          toastr.success('Task Created!', 'Success!');
          tasksIndex();
        }, function(error) {
          var msg = error.data.errors.message;
          toastr.error(msg, 'Error!');
        });
      };

      self.update = function() {
        TaskService.update(self.editing).then(function(response) {
          toastr.success('Task Updated!', 'Success!');
          tasksIndex();
        }, function(error) {
          var msg = error.data.errors.message;
          toastr.error(msg, 'Error!');
        });
      };

      self.delete = function(task) {
        TaskService.destroy(task.id).then(function(response) {
          toastr.success('Deleted!', 'Success!');
          tasksIndex();
        }, function(error) {
          var msg = error.data.errors.message;
          toastr.error(msg, 'Error!');
        });
      };

      tasksIndex();
    }
  ]);

angular.module('Scheduler').factory('TaskService', ['config', '$http',
  function(config, $http) {
    var metadata = {
      statusLabel: {
        scheduled: 'label-warning',
        executed: 'label-success',
        failed: 'label-danger'
      }
    };

    return {
      get_metadata: function() {
        return metadata;
      },

      index: function(params) {
        return $http.get(config.apiBase + "/tasks", params);
      },

      create: function(params) {
        return $http.post(config.apiBase + "/tasks", params);
      },

      update: function(params) {
        return $http.put(config.apiBase + "/tasks/" + params.id, params);
      },

      destroy: function(id) {
        return $http.delete(config.apiBase + "/tasks/" + id);
   },
    };
  }
]);
