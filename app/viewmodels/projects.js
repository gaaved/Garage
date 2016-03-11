// Generated by CoffeeScript 1.7.1
(function() {
  define(['knockout', 'task'], function(ko, t) {
    var taskCreator, viewModel;
    taskCreator = t;
    viewModel = {
      cache: null,
      editable: {
        Id: ko.observable(0),
        Name: ko.observable('')
      },
      projects: ko.observableArray(),
      remove: function(project) {
        return $.ajax({
          url: 'index.php/project/delete/' + project.Id,
          type: 'post',
          success: function(result) {
            if (!result) {
              return;
            }
            viewModel.projects.remove(project);
          }
        });
      },
      add: function() {
        var project;
        if (!viewModel.editable.Name()) {
          viewModel.editable.Name('ProjectName');
        }
        project = {
          Id: viewModel.editable.Id(),
          Name: viewModel.editable.Name()
        };
        $.ajax({
          url: viewModel.cache != null ? 'index.php/project/update/' + project.Id : 'index.php/project/create',
          type: 'post',
          data: {
            Project: project
          },
          success: function(response) {
            if (!response) {
              return;
            }
            project.Id = JSON.parse(response).id;
            viewModel.projects.push(project);
          }
        });
        viewModel.projects.remove(viewModel.cache);
        $('#name').val('').focus();
        viewModel.editable.Name(null);
        viewModel.editable.Id(null);
        viewModel.cache = null;
      },
      edit: function(project) {
        viewModel.cache = project;
        viewModel.editable.Id(project.Id);
        viewModel.editable.Name(project.Name);
      },
      activate: function() {
        $.ajax({
          url: 'index.php/project',
          type: 'get',
          mimeType: "application/json",
          dataType: "json",
          success: function(data) {
            viewModel.projects(data);
          }
        });
      },
      tasks: function(id) {
        return new taskCreator(id);
      }
    };
    return viewModel;
  });

}).call(this);