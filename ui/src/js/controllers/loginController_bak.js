'use strict';

//login page controller
  function loginCtrl($scope, $state, $http, $cookies, $cookieStore, accessFac) {
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
  .controller('loginCtrl', ['$scope', '$state', '$http', '$cookies', '$cookieStore', 'accessFac', loginCtrl]);
