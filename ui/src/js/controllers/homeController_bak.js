'use strict';

//home page controller
angular
  .module('nextwealth', [ ])
  .controller("homeCtrl", function($http, $scope, $state, DTOptionsBuilder, DTColumnBuilder, $cookies, $cookieStore, accessFac) {
    console.log($scope.text)
    $scope.JDs =[];
    //get JD's
    console.log("here");
    console.log("yesh");
    $http.get('/api/jd/?format=json').success(function(data, status) {
        //console.log(data['objects'][0]['job_title'])
        //for (var key in data['objects']){
            //console.log(data['objects'][key]['job_title']);
        //}
        $scope.JDs = data['objects'];
        //console.log($scope.JDs)
    }).error(function( error){ console.log("error")});

    $scope.tableData = {};

    // Datatable handle
    $scope.dtOptions = DTOptionsBuilder.fromSource('data.json')
        .withOption('stateSave', true)
        .withPaginationType('full_numbers');
    //console.log("here2");
    //console.log($scope.dtOptions);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('id').withTitle('id'),
        DTColumnBuilder.newColumn('name').withTitle('name'),
        DTColumnBuilder.newColumn('walk_in_date').withTitle('walk in date'),
        DTColumnBuilder.newColumn('status').withTitle('status'),
        //DTColumnBuilder.newColumn('email').withTitle('email'),
        //DTColumnBuilder.newColumn('phone').withTitle('phone'),
        //DTColumnBuilder.newColumn('location').withTitle('location')
    ];
    $scope.dtInstance = {};

    $scope.logout = function() {

      $http.get('/apis/logout').success(function(data, status) {

        $cookieStore.remove("session_key");
        console.log($cookieStore.get('session_key'));
        $state.go('login');
      }).error(function( error){

        $state.go('login');
        $cookieStore.remove("session_key");
        console.log($cookieStore.get('session_key')); 
      });
    }
  })
