define (['angular','components/shared/index'],function(angular) {
   var areasApp = angular.module('areasApp', ['powerSchoolModule']);
   areasApp.controller ('areasCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.areasList = [];
      getService.getAreas('areas.json')
      .then(function(retData) {
         retData.pop();
         $scope.areasList = retData;
         closeLoading();
      });
      $scope.areasEdit = function(formData) {
          postService.postAreas('areas.json', formData)
          .then(function (retData) {
              retData.pop();
              $scope.areasList = retData;
              psDialogClose();
          });
      }
   });
    
   areasApp.factory ('getService', function($http) {
      //factory code
      return {
          getAreas : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    areasApp.factory ('postService', function($http) {
        //factory code
        return {
            postAreas : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});