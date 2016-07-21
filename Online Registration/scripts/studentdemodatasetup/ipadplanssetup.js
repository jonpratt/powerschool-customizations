define (['angular','components/shared/index'],function(angular) {
   var ipadplansApp = angular.module('ipadplansApp', ['powerSchoolModule']);
   ipadplansApp.controller ('ipadplansCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.ipadplansList = [];
      getService.getIpadplans('ipadplans.json')
      .then(function(retData) {
         retData.pop();
         $scope.ipadplansList = retData;
         closeLoading();
      });
      $scope.ipadplansEdit = function(formData) {
          postService.postIpadplans('ipadplans.json', formData)
          .then(function (retData) {
              retData.pop();
              $scope.ipadplansList = retData;
              psDialogClose();
          });
      }
   });
    
   ipadplansApp.factory ('getService', function($http) {
      //factory code
      return {
          getIpadplans : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    ipadplansApp.factory ('postService', function($http) {
        //factory code
        return {
            postIpadplans : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});