define (['angular','components/shared/index'],function(angular) {
   var householdrelationshipsApp = angular.module('householdrelationshipsApp', ['powerSchoolModule']);
   householdrelationshipsApp.controller ('householdrelationshipsCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.householdrelationshipsList = [];
      getService.getHouseholdrelationships('householdrelationships.json')
      .then(function(retData) {
         retData.pop();
         $scope.householdrelationshipsList = retData;
         closeLoading();
      });
      $scope.householdrelationshipsEdit = function(formData) {
          postService.postHouseholdrelationships('householdrelationships.json', formData)
          .then(function (retData) {
              retData.pop();
              $scope.householdrelationshipsList = retData;
              psDialogClose();
          });
      }
   });
    
   householdrelationshipsApp.factory ('getService', function($http) {
      //factory code
      return {
          getHouseholdrelationships : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    householdrelationshipsApp.factory ('postService', function($http) {
        //factory code
        return {
            postHouseholdrelationships : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});