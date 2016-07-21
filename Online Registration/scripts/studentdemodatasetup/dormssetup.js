define (['angular','components/shared/index'],function(angular) {
   var dormsApp = angular.module('dormsApp', ['powerSchoolModule']);
   dormsApp.controller ('dormsCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.dormsList = [];
      getService.getDorms('dorms.json')
      .then(function(retData) {
         retData.pop();
         $scope.dormsList = retData;
         closeLoading();
      });
      $scope.dormsEdit = function(formData) {
          postService.postDorms('dorms.json', formData)
          .then(function (retData) {
              retData.pop();
              $scope.dormsList = retData;
              psDialogClose();
          });
      }
   });
    
   dormsApp.factory ('getService', function($http) {
      //factory code
      return {
          getDorms : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    dormsApp.factory ('postService', function($http) {
        //factory code
        return {
            postDorms : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});