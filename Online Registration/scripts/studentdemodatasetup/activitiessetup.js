define (['angular','components/shared/index'],function(angular) {
   var activitiesApp = angular.module('activitiesApp', ['powerSchoolModule']);
   activitiesApp.controller ('activitiesCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.activitiesList = [];
      getService.getActivities('activities.json')
      .then(function(retData) {
         retData.pop();
         $scope.activitiesList = retData;
         closeLoading();
      });
      $scope.activitiesEdit = function(formData) {
          postService.postActivities('activities.json', formData)
          .then(function (retData) {
              retData.pop();
              $scope.activitiesList = retData;
              psDialogClose();
          });
      }
   });
    
   activitiesApp.factory ('getService', function($http) {
      //factory code
      return {
          getActivities : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    activitiesApp.factory ('postService', function($http) {
        //factory code
        return {
            postActivities : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});