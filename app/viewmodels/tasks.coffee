define ['knockout'],(ko) -> 
	result = (id)->
		projectId = id
		viewModel =
			cache: null
			editable: 
				Id : ko.observable 0
				Name : ko.observable ''
				ProjectId: ko.observable projectId
				Status: ko.observable 0
				Priority: ko.observable 0
			tasks : ko.observableArray()
			remove: (task) ->
				$.ajax
					url: 'index.php/task/delete/'+ task.Id
					type: 'post'
					success: (result) ->
						if !result then return
						viewModel.tasks.remove task
						viewModel.editable.Name null
						viewModel.editable.Id null
						viewModel.editable.Status null
						viewModel.editable.Priority null
						return
				return 
			add: () ->

				if !viewModel.editable.Id() and !viewModel.editable.Name()  then return
				console.log 'test'
				viewModel.tasks.remove viewModel.cache 
				task =  
				  Id: viewModel.editable.Id() 
				  Name: viewModel.editable.Name() 
				  ProjectId: projectId
				  Status: viewModel.editable.Status()
				$.ajax 
					url: if viewModel.cache? then 'index.php/task/update/' + task.Id else 'index.php/task/create' 
					type: 'post'
					data:
						Task: task
					success: (result) ->
						if !result then return
						task.Id = JSON.parse(result).id
						viewModel.tasks.push task	
						return
				$('#name').val('').focus()
				viewModel.editable.Name null
				viewModel.editable.Id null
				viewModel.editable.Status null
				viewModel.editable.Priority null
				viewModel.cache = null 
				return
			edit: (task) ->
				viewModel.cache = task
				viewModel.editable.Id task.Id
				viewModel.editable.Name task.Name
				viewModel.editable.Status task.Status
				viewModel.editable.Priority task.Priority
				return
			init: ()->
				$.ajax
					url: 'index.php/task/index/'+projectId
					type:'get'
					mimeType: "application/json"
					dataType: "json"
					success: (data)-> 
						viewModel.tasks data
						return
			priorityUp: (task)->
				++task.Priority
				$.ajax 
					url: 'index.php/task/update/' + task.Id
					type: 'post'
					data:
						Task: task
					success: (result) ->
						if !result then task.Status = 0
						viewModel.tasks.remove task
						viewModel.tasks.push task
						return
				return;
			priorityDown: (task) ->
				--task.Priority
				$.ajax 
					url: 'index.php/task/update/' + task.Id
					type: 'post'
					data:
						Task: task
					success: (result) ->
						if !result then task.Status = 0
						viewModel.tasks.remove task
						viewModel.tasks.push task
						return
				return;
			done: (task)->
				task.Status = if +task.Status == 0 then 1 else 0
				$.ajax 
					url: 'index.php/task/update/' + task.Id
					type: 'post'
					data:
						Task: task
					success: (result) ->
						if !result then task.Status = 0
						viewModel.tasks.remove task
						viewModel.tasks.push task
						return
				return;
	return (id)->
			ret = new result(id);
			ret.init()
			return ret;
