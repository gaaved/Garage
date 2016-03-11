define ['knockout','task'],(ko,t) -> 
	taskCreator = t
	viewModel =
		cache: null
		editable: 
			Id : ko.observable(0)
			Name : ko.observable('')
		projects : ko.observableArray()
		remove: (project) ->
			$.ajax
				url: 'index.php/project/delete/'+ project.Id
				type: 'post'
				success: (result) ->
					if !result then return
					viewModel.projects.remove project
					return
		add: () ->

			if !viewModel.editable.Name()  then viewModel.editable.Name('ProjectName')
			project =  
  				Id : viewModel.editable.Id() 
  				Name : viewModel.editable.Name()
			$.ajax
				url: if viewModel.cache? then 'index.php/project/update/' + project.Id else 'index.php/project/create' 
				type: 'post'
				data: 
					Project: project
				success: (response) ->
					if !response then return
					project.Id = JSON.parse(response).id
					viewModel.projects.push project
	 			return
			viewModel.projects.remove viewModel.cache 
			$('#name').val('').focus()
			viewModel.editable.Name null
			viewModel.editable.Id null
			viewModel.cache = null 
			return
		edit: (project) ->
			viewModel.cache = project
			viewModel.editable.Id project.Id
			viewModel.editable.Name project.Name
			return
		activate: () ->
			$.ajax
				url: 'index.php/project'
				type:'get'
				mimeType: "application/json"
				dataType: "json"
				success: (data)-> 
					viewModel.projects data
					return
			return
		tasks: (id)->
			new taskCreator(id)
	return viewModel
