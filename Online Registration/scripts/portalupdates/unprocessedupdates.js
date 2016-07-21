define (['angular','components/shared/index'],function(angular) {
    
   var unprocessedupdatesApp = angular.module('unprocessedupdatesApp', ['powerSchoolModule']);

    //unprocessed primary updates
    
   unprocessedupdatesApp.controller ('unprocessedupdatesCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.unprocessedupdatesList = [];
      getService.getUnprocessedupdates('unprocessedupdates.json')
      .then(function(retData) {
         retData.pop();
         $scope.unprocessedupdatesList = retData;
         closeLoading();
      });
      $scope.unprocessedupdatesEdit = function(formData) {
          postService.postUnprocessedupdates('unprocessedupdates.json', formData)
          .then(function(retData) {
              retData.pop();
              $scope.unprocessedupdatesList = retData;
              psDialogClose();
          });
      }
   });

    //unprocessed secondary household updates
    
   unprocessedupdatesApp.controller ('unprocessedSHUpdatesCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.unprocessedSHUpdatesList = [];
      getService.getUnprocessedupdates('unprocessedshupdates.json')
      .then(function(retData) {
         retData.pop();
         $scope.unprocessedSHUpdatesList = retData;
         closeLoading();
      });
      $scope.unprocessedSHUpdatesEdit = function(formData) {
          postService.postUnprocessedupdates('unprocessedshupdates.json', formData)
          .then(function(retData) {
              retData.pop();
              $scope.unprocessedSHUpdatesList = retData;
              psDialogClose();
          });
      }
   });
    
   unprocessedupdatesApp.factory ('getService', function($http) {
      //factory code
      return {
          getUnprocessedupdates : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    unprocessedupdatesApp.factory ('postService', function($http) {
        //factory code
        return {
            postUnprocessedupdates : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});