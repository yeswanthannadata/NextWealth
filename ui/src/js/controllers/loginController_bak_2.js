'use strict';

//login page controller
  function loginCtrl($scope, $state, $http, $cookies, $cookieStore, accessFac, productService) {
    $scope.username;
    $scope.password;
    $scope.submit = function(username, password) {

      var data = $.param({
                   username: username,
                   password: password
                 });

      $http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";

      $http.post('/api/login', data).success(function(data, status, header) {
        $scope.user = data["user_type"]
        var use = $scope.user
        $scope.callTo = productService.addResu(use);
        console.log('At office');
        //console.log(callTo);
        /*$scope.callTo = function(use){
            productService.addResu(use);
            console.log(use);
        };*/
        //myfunction(use)
        //console.log('Good Morning');
        //console.log($scope.callToAdd)
        //var resu = { param:$scope.user}
        //console.log($scope.user);
        if ( data["message"] == "Success") {
          $cookieStore.put('session_key',data.data.session_key);
          console.log($cookieStore.get('session_key'));
          console.log(data);
          if(data["user_type"] == "Team Lead"){
            $state.go('home');
        }else{
            $state.go('home_1');
        }
        }
      });
    }
  }
angular
  .module('nextwealth')
  .controller('loginCtrl', ['$scope', '$state', '$http', '$cookies', '$cookieStore', 'accessFac', 'productService', loginCtrl])
  .service('productService', function() {
    var resu = [];
    var addResu = function(obj){
        resu.push(obj);
    };
    var getResu = function(){
        return resu;
    };
    return {
        addResu: addResu,
        getResu: getResu
    };
    });
