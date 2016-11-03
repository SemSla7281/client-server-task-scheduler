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
