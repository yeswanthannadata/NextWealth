'use strict';

//home page controller
angular
  .module('nextwealth', [ ])
  .controller("homeCtrl", function($http, $scope, $state, DTOptionsBuilder, DTColumnBuilder, $cookies, $cookieStore, accessFac, productService) {
    console.log($scope.text)
    $scope.JDs =[];
    $scope.user_role = productService.getResu();
    console.log($scope.user_role);
    $scope.submit = function () {
        if ($scope.text) {
            var select = $scope.selected;
            $http.get('/api/add_candidate/?name='+$scope.text+'&date='+$scope.date+'&jd='+select).success(function(data, status) {
                $("#display").html("Added Sucessfully");
                $("#text").val('');
                $("#date").val('');
            }).error(function( error){ console.log("error")});
        }
    };
    $http.get('/api/jds').success(function(data, status) {
            $scope.JDdefault = data[0]['name'];
        for (var k in data){
            $scope.JDs.push(data[k]['name']);
        }
        console.log($scope.JDs);
    }).error(function( error){ console.log("error")});

    $scope.tableData = {};
    $scope.someClickHandler = someClickHandler;
    $scope.dtOptions = DTOptionsBuilder.fromSource('data.json')
        .withOption('stateSave', true)
        .withPaginationType('full_numbers')
        .withOption('rowCallback', rowCallback);
    $scope.dtColumns = [
        DTColumnBuilder.newColumn('name').withTitle('name'),
        DTColumnBuilder.newColumn('walk_in_date').withTitle('walk in date'),
        DTColumnBuilder.newColumn('status').withTitle('status'),
        //DTColumnBuilder.newColumn('email').withTitle('email'),
        //DTColumnBuilder.newColumn('phone').withTitle('phone'),
        //DTColumnBuilder.newColumn('location').withTitle('location')
    ];
    function someClickHandler(info) {
        $scope.message = info.name + ' - ' + info.walk_in_date + ' - ' + info.status;
        console.log($scope.message);
    }
    function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
        $('td', nRow).unbind('click');
        $('td', nRow).bind('click', function() {
            $scope.$apply(function() {
                $scope.someClickHandler(aData);
            });
        });
        return nRow;
    }
    $scope.dtInstance = {};
    $scope.clickHandler = function(){
     console.log('Here is out');
    };
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
  $(document).ready(function(){
    function default_table(){
        console.log("in table");
        $('.drop_down').trigger("change");
    }
    setTimeout(default_table, 2000);
  });
    $("body").on("click","#close",function(){
        $('.drop_down option:selected').prop('selected',false);
        $('.drop_down').trigger("change");
    })
