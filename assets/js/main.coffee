require 'angular/angular'
require 'angular-ui-router/build/angular-ui-router'

require 'marked'
require 'angular-md/dist/angular-md'
_ = require 'lodash'

angularDeps = [
	'ui.router'
	'yaru22.md'
]

angular.module('sampleRootsApp', angularDeps)

angular.module('sampleRootsApp').controller('blogCtrl', ['$state', ($state) ->
	@contentSkeleton = window.contentSkeleton
	@state = $state
	return
])

angular.module('sampleRootsApp').controller('categoryCtrl', ['$stateParams', ($stateParams) ->
	@cat = $stateParams.category
	@posts = window.contentSkeleton.posts[@cat].items
	@contentSkeleton = window.contentSkeleton
	return
])

	
angular.module('sampleRootsApp').controller('postCtrl', ['$stateParams', ($stateParams) ->
	@cat = $stateParams.category
	@postslug = $stateParams.post
	@post = _.find( window.contentSkeleton.posts[@cat].items, (i) => i.slug == @postslug )
	@contentSkeleton = window.contentSkeleton
	return
])


angular.module('sampleRootsApp').controller('pageCtrl', ['$stateParams', ($stateParams) ->
	@pageslug = $stateParams.page
	@page = _.find( window.contentSkeleton.pages.items, (i) => i.slug == @pageslug )
	return
])

angular.module('sampleRootsApp').config( ['$stateProvider', '$urlRouterProvider', '$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->
		
		$locationProvider.html5Mode(true)
#		
#		$urlRouterProvider.rule( ($injector, $location) ->
#			    path = $location.url()
#			
#			    # check to see if the path already has a slash where it should be
#			    if (path[path.length - 1] == '/' || path.indexOf('/?') > -1)
#			        return
#			
#			    if (path.indexOf('?') > -1) 
#			        path.replace('?', '/?')
#			
#			    return path + '/';
#		)
#		
#		
		$urlRouterProvider.otherwise '/'
		
		$stateProvider.state('index', { 
		  		url: '/'
		  		templateUrl: 'partial/index.html'
		})
		
		$stateProvider.state('blog', { 
		  		url: '/posts/'
		  		templateUrl: '/partial/blog.html'
			  	controller: 'blogCtrl as blogModel'
		})
		
		$stateProvider.state('wiki', { 
		  		url: '/wiki/'
		  		templateUrl: '/partial/wiki.html'
			  	controller: 'wikiCtrl as wikiModel'
		})
		
		$stateProvider.state('blog.category', { 
		  		url: ':category'
		  		templateUrl: '/partial/category.html'
			  	controller: 'categoryCtrl as categoryModel'
		})
		
		$stateProvider.state('page', { 
		  		url: '/content/:page'
		  		templateUrl: (params) -> 'pages/' + params.page + '.html'
			  	controller: 'pageCtrl as pageModel'
		})
		
		$stateProvider.state('blog.post', { 
		  		url: ':category/:post'
		  		templateUrl: (params) -> 'posts/' + params.category + '/' + params.post + '.html'
			  	controller: 'postCtrl as postModel'
		})
		
		$stateProvider.state('wiki.page', { 
		  		url: ':wikipage'
		  		templateUrl: (params) -> 'wiki/' + params.wikipage + '.html'
			  	controller: 'wikiPageCtrl as wikiPageModel'
		})
			
		$stateProvider.state('error', { 
	      		url: '/error'
	      		templateUrl: 'partial/error.html'
		})
		
		return
		
])

