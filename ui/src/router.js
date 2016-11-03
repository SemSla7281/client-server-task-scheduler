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
