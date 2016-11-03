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
