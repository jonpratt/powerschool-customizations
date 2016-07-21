define (['angular','components/shared/index'],function(angular) {
   var custodytypesApp = angular.module('custodytypesApp', ['powerSchoolModule']);
   custodytypesApp.controller ('custodytypesCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.custodytypesList = [];
      getService.getCustodytypes('custodytypes.json')
      .then(function(retData) {
         retData.pop();
         $scope.custodytypesList = retData;
         closeLoading();
      });
      $scope.custodytypesEdit = function(formData) {
          postService.postCustodytypes('custodytypes.json', formData)
          .then(function (retData) {
              retData.pop();
              $scope.custodytypesList = retData;
              psDialogClose();
          });
      }
   });
    
   custodytypesApp.factory ('getService', function($http) {
      //factory code
      return {
          getCustodytypes : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    custodytypesApp.factory ('postService', function($http) {
        //factory code
        return {
            postCustodytypes : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});