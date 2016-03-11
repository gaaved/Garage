requirejs.config 
	paths: 
		'text' : '../lib/require/text'
		'durandal':'../lib/durandal/js'
		'plugins' : '../lib/durandal/js/plugins'
		'transitions' : '../lib/durandal/js/transitions'
		'knockout': '../lib/knockout/knockout-3.0.0'
		'jquery': '../lib/jquery/jquery-1.11.0.min'
		'jqueryui': '../lib/jquery/jquery-ui.min'
		'task': 'viewmodels/tasks'
			
define ['durandal/system','durandal/app','durandal/viewLocator'], (system,app,locator) -> 
	system.debug on
	app.title = 'TODO List'
	app.configurePlugins 
		router: on 
	app.start().then ->
		locator.useConvention()
		app.setRoot 'viewmodels/shell','entrance'
		return 
	return 




