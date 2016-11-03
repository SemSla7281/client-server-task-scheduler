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
