define (['angular','components/shared/index'],function(angular) {
   var invApp = angular.module('invApp', ['powerSchoolModule']);
   invApp.controller ('invCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.invList = [];
      getService.getInv('inventory.json')
      .then(function(retData) {
         retData.pop();
         $scope.invList = retData;
         closeLoading();
      });
      $scope.invEdit = function(formData) {
          postService.postInv('inventory.json', formData)
          .then(function (retData) {
              retData.pop();
              $scope.invList = retData;
              psDialogClose();
          });
      }
   });
    
   invApp.factory ('getService', function($http) {
      //factory code
      return {
          getInv : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    invApp.factory ('postService', function($http) {
        //factory code
        return {
            postInv : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});