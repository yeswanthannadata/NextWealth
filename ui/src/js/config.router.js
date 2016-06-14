(function(){

  //route provider
 var app = angular.module('nextwealth')
    app.config(function($stateProvider, $urlRouterProvider){

      // For any unmatched url, send to /route1
      $urlRouterProvider.otherwise("/login");

      $stateProvider
        .state('login', {
            url: '/login',
            templateUrl: 'views/login.html',
            resolve: {
              check :function(accessFac, $location){
                if(accessFac.checkCookie()){
                  $location.path('/home');
                }
              },
              deps: ['$ocLazyLoad', function ($ocLazyLoad) {
                return $ocLazyLoad.load('js/controllers/loginController.js');
              }]
            }
        })
        .state('home', {
            url: '/home',
            params: {
                obj: null
            },
            templateUrl: 'views/home.html',
            resolve: {
              check :function(accessFac, $location){
                if(accessFac.checkCookie()){
                  console.log("success");
                } else {
                  $location.path('/login');
                }
              },
              deps: ['$ocLazyLoad', function ($ocLazyLoad) {
                return $ocLazyLoad.load('css/home.css').then(function () { return $ocLazyLoad.load('js/controllers/homeController.js') });
              }]
            }
        })
.state('home_1', {
            url: '/home_1',
            templateUrl: 'views/new_home_temp.html',
            resolve: {
              check :function(accessFac, $location){
                if(accessFac.checkCookie()){
                  console.log("success");
                } else {
                  $location.path('/login');
                }
              },
              deps: ['$ocLazyLoad', function ($ocLazyLoad) {
                return $ocLazyLoad.load('css/home.css').then(function () { return $ocLazyLoad.load('js/controllers/homeController.js') }); 
              }]
            }
        })
      })

}());
