'use strict';

//home page controller
angular
  .module('nextwealth', [ ])
  .controller("homeCtrl", function($http, $scope, $state, DTOptionsBuilder, DTColumnBuilder, $cookies, $cookieStore, accessFac) {
    console.log($scope.text)
    $scope.JDs =[];
    //get JD's
    console.log("here");
    //$scope.list = []
    //$scope.text = ""
    $scope.submit = function () {
        if ($scope.text) {
            //$scope.list.push($scope.text);
            //$scope.text = '';
            var select = $scope.selected;
            $http.get('/api/add_candidate/?name='+$scope.text+'&date='+$scope.date+'&jd='+select).success(function(data, status) {
                //$(".modal-body").empty();
                console.log('Hi');
                $("#display").html("Added Sucessfully");
                //$("#text").val('');
                //$("#date").val('');
                //$("#sel").empty();
                //$(".modal-body").empty();
                //$(".modal-header").empty();
            }).error(function( error){ console.log("error")});
        }
    };
    $http.get('/api/jds').success(function(data, status) {
        console.log("Yesh Here");
        //console.log(data);
        //for (var key in data){
            //console.log(data[key]['name']);
            //$scope.JDs = data[key];
            //console.log($scope.JDs)
        //}
        for (var k in data){
            $scope.JDs.push(data[k]['name']);
        }
        console.log($scope.JDs);
        //console.log($scope.JDs);
    }).error(function( error){ console.log("error")});

    $scope.tableData = {};
    //$scope.someClickHandler = someClickHandler;
    // Datatable handle
    $scope.dtOptions = DTOptionsBuilder.fromSource('data.json')
        .withOption('stateSave', true)
        .withPaginationType('full_numbers');
        //.withOption('rowCallback', rowCallback);
    //console.log("here2");
    //console.log($scope.dtOptions);
    $scope.dtColumns = [
        //DTColumnBuilder.newColumn('id').withTitle('id'),
        DTColumnBuilder.newColumn('name').withTitle('name'),
        DTColumnBuilder.newColumn('walk_in_date').withTitle('walk in date'),
        DTColumnBuilder.newColumn('status').withTitle('status'),
        //DTColumnBuilder.newColumn('email').withTitle('email'),
        //DTColumnBuilder.newColumn('phone').withTitle('phone'),
        //DTColumnBuilder.newColumn('location').withTitle('location')
    ];
    /*function someClickHandler(info) {
        $scope.message = info.name + ' - ' + info.walk_in_date + ' - ' + info.status;
    }
    function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
        // Unbind first in order to avoid any duplicate handler (see https://github.com/l-lin/angular-datatables/issues/87)
        $('td', nRow).unbind('click');
        $('td', nRow).bind('click', function() {
            $scope.$apply(function() {
                vm.someClickHandler(aData);
            });
        });
        return nRow;
    }*/
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
    /*console.log('Here is out');
    $("modal-footer").on("click","#close",function(){
    console.log("Close button clicked");
    //$("#jddropi").attr('selected','selected');
    });*/

