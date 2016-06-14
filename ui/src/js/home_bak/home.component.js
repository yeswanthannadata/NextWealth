;(function (angular) {
  "use strict";
  angular.module("home")
         .component("home", {

           "templateUrl": "/js/home/home.html",
           "controller"  : ["$rootScope", "Session", "$http", "$scope", "$state","DTOptionsBuilder", "DTColumnBuilder",

             function ($rootScope, Session,$http, $scope, $state, DTOptionsBuilder, DTColumnBuilder ) {
                $scope.JDs =[];
                $scope.submit = function () {
                    if ($scope.text) {
                        var select = $scope.selected;
                        $http.get('/api/add_candidate/?name='+$scope.text+'&date='+$scope.date+'&jd='+select)
                        .success(function(data, status) {
                            $("#display").html("Added Sucessfully");
                            $("#text").val('');
                            $("#date").val('');
                        }).error(function( error){ console.log("error")});
                    }
                };
                $http.get('/api/jds').success(function(data, status) {
                        $scope.JDdefault = data['result'][0]['name'];
                        $scope.dtInstance.changeData('/api/candidates/?jd='+$scope.JDdefault);
                    for (var key in data['result']){
                        $scope.JDs.push(data['result'][key]['name']);
                    }
                    console.log($scope.JDs);
                }).error(function( error){ console.log("error")});

                $scope.tableData = {};
                $scope.someClickHandler = someClickHandler;
                $scope.dtOptions = DTOptionsBuilder.fromSource('/api/candidates/?jd=ldksalfj')
                    .withOption('stateSave', true)
                    .withPaginationType('full_numbers')
                    .withOption('rowCallback', rowCallback);
                $scope.dtColumns = [
                    DTColumnBuilder.newColumn('name').withTitle('name'),
                    DTColumnBuilder.newColumn('walk_in_date').withTitle('walk in date'),
                    DTColumnBuilder.newColumn('status').withTitle('status'),
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
            }]
        });
}(window.angular));
