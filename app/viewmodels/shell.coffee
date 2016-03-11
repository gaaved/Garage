define ['plugins/router'], (router) ->
	router: router
	activate: () ->
		router.map([{route:'', moduleId:'viewmodels/projects',nav:true},{route:'project/:id',moduleId:'viewmodels/tasks',nav:true}])
			.buildNavigationModel()
			.mapUnknownRoutes('viewmodels/error', 'not-found')
			.activate()

