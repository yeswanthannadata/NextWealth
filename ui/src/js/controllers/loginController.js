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
        if ( data["message"] == "Success") {
          $cookieStore.put('session_key',data.data.session_key);
          console.log($cookieStore.get('session_key'));
          console.log(data);
          $state.go('home');
        }
      });
    }
  }
angular
  .module('nextwealth')
  .service('productService', function() {
    var resu = '';
    var addResu = function(obj){
        resu = obj;
    };
    var getResu = function(){
        return resu;
    };
    return {
        addResu: addResu,
        getResu: getResu
    };
    })
  .controller('loginCtrl', ['$scope', '$state', '$http', '$cookies', '$cookieStore', 'accessFac', 'productService', loginCtrl]);

