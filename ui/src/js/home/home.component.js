;(function (angular) {
  "use strict";
  angular.module("home")
         .component("home", {

           "templateUrl": "/js/home/home.html",
           "controller"  : ["$rootScope", "Session", "$http", "$scope", "$state","DTOptionsBuilder", "DTColumnBuilder",

             function ($rootScope, Session,$http, $scope, $state, DTOptionsBuilder, DTColumnBuilder ) {

                var self = this;
                this.user = Session.get();

                var isAgent;

                if (this.user.roles.indexOf("Agent") >= 0) {

                  isAgent = true;

                  this.user.role = "Agent";
    
                  if (this.user.roles.indexOf("Admin") >= 0) {

                    this.user.role = "Admin";
                  }
                } else {

                  this.user.role = "SPOC";
                }

                this.info = {

                    "fname"  : "",
                    "lname"  : "",
                    "date"   : "",
                    "mobile" : "",
                    "email"  : "",
                    "status" : isAgent ? "New": "Scheduled",
                    "remarks": ""
                }

                this.isAgent = isAgent;

                self.JDs =[];
                self.JDdes ={};
                $scope.locations = [];
                /*$scope.submit = function () {

                    if ($scope.text) {
                        var select = $scope.selected;
                        $http.get('/api/add_candidate/?name='+name+'&date='+date+'&jd='+jd+'&email='+email+'&mobile='+mobile)
                        .success(function(data, status) {
                            $("#display").html("Added Sucessfully");
                            $("#text").val('');
                            $("#date").val('');
                        }).error(function( error){ console.log("error")});
                    }
                };*/

                function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    $(nRow).on('click', 'td', function() {
                        $scope.$apply(function() {
                            $scope.tableClickHandler(aData);
                        });
                    });
                    return nRow;
                }


                //edit details
                this.edit_data = function (info) {
                
                   var mode = $('.lname').attr('data-mode');
                   if(mode == 'add'){
                        var jd = $( ".drop_down option:selected" ).text();
                        $http.get('/api/add_candidate/?fname='+info.fname+'&lname='+info.lname+'&date='+info.date+'&jd='+jd+
                                  '&email='+info.email+'&mobile='+info.mobile+'&remarks='+info.remarks).success(function(data, status) {
                            $(".success_message").html("Added Successfully");
                            $(".success_message").show();
                            $("#text").val('');
                            $("#date").val('');
                            var jd = $( ".drop_down option:selected" ).text();
                            $scope.dtOptions = DTOptionsBuilder.fromSource('/api/candidates/?jd='+jd)
                                               .withOption('fnRowCallback', rowCallback);
                        }).error(function( error){ console.log("error")});
                    }
                    else{

                        var id = $('.fname').attr('data-id');
                        $http.get('/api/update_candidate/?fname='+info.fname+'&lname='+info.lname+'&date='+
                            info.date+'&mobile='+info.mobile+'&email='+info.email+'&status='+info.status+'&id='+id+'&remarks='+info.remarks)
                            .success(function(data, status) {

                                $(".success_message").html("Updated Successfully");
                                $(".success_message").show();
                                var jd = $( ".drop_down option:selected" ).text();
                                $scope.dtOptions = DTOptionsBuilder.fromSource('/api/candidates/?jd='+jd)
                                .withOption('fnRowCallback', rowCallback);
                            }).error(function( error){ console.log("error")});
                   }
                };
                $http.get('/api/jds').success(function(data, status) {

                        self.JDdefault = data['result'][0]['name'] + " - " + data['result'][0]['location'] + " - " + data['result'][0]['id'];
                        $scope.dtInstance.changeData('/api/candidates/?jd='+self.JDdefault);
                    for (var key in data['result']){
                        self.JDs.push(data['result'][key]['name'] + " - " + data['result'][0]['location'] + " - " + data['result'][key]['id']);
                        self.JDdes[data['result'][key]['name']] = {};
                        self.JDdes[data['result'][key]['name']]["candidates_required"] = data['result'][key]['candidates_req'];
                        self.JDdes[data['result'][key]['name']]["Location"] = data['result'][key]['location'];
                        self.JDdes[data['result'][key]['name']]["min_experience"] = data['result'][key]['min_experience'];
                        self.JDdes[data['result'][key]['name']]["maximum experience"] = data['result'][key]['max_experience'];
                        self.JDdes[data['result'][key]['name']]["min_salary"] = data['result'][key]['min_salary'];
                        self.JDdes[data['result'][key]['name']]["max_salary"] = data['result'][key]['max_salary'];
                        //$scope.JDdes.push("Candidates required" + ":" + data['result'][key]['candidates_req'] + " - " + "Post" + ":" + data['result'][key]['name'] + " - " +  "Location" + ":" + data['result'][key]['location'] + " - " + "Minimum experience" + ":" + data['result'][key]['min_experience'] + " - " + "maximum experience" + ":" + data['result'][key]['max_experience']);
                    }

                }).error(function( error){ console.log("error")});

                $scope.tableData = {};
                $scope.tableClickHandler = tableClickHandler;
                $scope.dtOptions = DTOptionsBuilder.fromSource('/api/candidates/?jd=ldksalfj')
                    .withOption('stateSave', true)
                    .withPaginationType('full_numbers')
                    .withOption('fnRowCallback', rowCallback);
                    /*.withOption('fnRowCallback', function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {

                          $(nRow).on('click','td', function() {
                            $scope.$apply(function() {
                                $scope.tableClickHandler(aData);
                            }); 
                          });

                        return nRow;
                    });*/
                $scope.dtColumns = [
                    DTColumnBuilder.newColumn('created_at').withTitle('Submitted'),
                    DTColumnBuilder.newColumn('name').withTitle('Candidate'),
                    DTColumnBuilder.newColumn('walk_in_date').withTitle('Scheduled'),
                    DTColumnBuilder.newColumn('mobile_number').withTitle('Mobile'),
                    DTColumnBuilder.newColumn('email_id').withTitle('E-mail'),
                    DTColumnBuilder.newColumn('status').withTitle('Status'),
                    DTColumnBuilder.newColumn('agent_name').withTitle('Agent'),
                    DTColumnBuilder.newColumn('id').withTitle('ID').withClass('hide'),
                    DTColumnBuilder.newColumn('remarks').withTitle('Remarks').withClass('hide'),
                ];

                //on click each row
                //$scope.tableClickHandler = tableClickHandler;
                function tableClickHandler(info) {
                    console.log(info);
                    $('.lname').attr('data-mode','a');
                    $('.modal-title').html('Edit Candidate');
                    var name = info.name.split(' ');
                    $('.fname').val(name[0]);
                    $('.lname').val(name[1]);
                    $('.fname').attr('data-id', info.id);
                    var date = info.walk_in_date.split("/");
                    $('.date').val(date[2]+"-"+date[0]+"-"+date[1]);
                    $('.mobile').val(info.mobile_number);
                    $('.email').val(info.email_id);
                    $('.remarks').val(info.remarks);
                    $('.location').val(info.location);
                    $('[name=status] option').filter(function() {
                        return ($(this).text() == info.status);
                    }).prop('selected', true);
                    $('#candidate_modal').modal();
                }

                //click row
                /*function rowCallback(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    $('td', nRow).unbind('click');
                    $('td', nRow).bind('click', function() {
                        $scope.$apply(function() {
                            $scope.tableClickHandler(aData);
                        });
                    });
                    return nRow;
                }*/


                //jd desc
                /*$scope.jd_desc = jd_desc;
                function jd_desc() {
                    var jd = $( ".drop_down option:selected" ).text();
                    console.log($scope.JDdes['Java Developer']);
                       if(jd.indexOf('Java Developer') > -1){
                            $('.jd_des').html('');
                            $('.jd_des').html($scope.JDdes['Java Developer']);
                        }
                } */


                //on click ADD
                $scope.add_candidate = add_candidate;
                function add_candidate() {
                    $('.lname').attr('data-mode','add');
                    $('.fname').val('');
                    $('.lname').val('');
                    $('.date').val('');
                    $('.mobile').val('');
                    $('.email').val('');
                    $('.location').val('');
                    $('.remarks').val('');
                    $("select[name='status']").val("New");
                    $('.modal-title').html('Add Candidate');
                    
                    $('#candidate_modal').modal();
                }

                $scope.dtInstance = {};

               self.$onInit = function () {

                 $("#fileupload").uploadFile({
                      url:"/api/upload/",
                      fileName:"myfile",
                      dragDrop: false,
                      onSuccess:function(){
                          $('.ajax-file-upload-statusbar').hide();
                      },
                 });
                 $(document).on('click','.close_modal',function(){
                      $('.success_message').html('');
                      $('.success_message').hide();
                 });
               };

            }]
        });
}(window.angular));
