define (['angular','components/shared/index'],function(angular) {
   var phonetypesApp = angular.module('phonetypesApp', ['powerSchoolModule']);
   phonetypesApp.controller ('phonetypesCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.phonetypesList = [];
      getService.getPhonetypes('phonetypes.json')
      .then(function(retData) {
         retData.pop();
         $scope.phonetypesList = retData;
         closeLoading();
      });
      $scope.phonetypesEdit = function(formData) {
          postService.postPhonetypes('phonetypes.json', formData)
          .then(function (retData) {
              retData.pop();
              $scope.phonetypesList = retData;
              psDialogClose();
          });
      }
   });
    
   phonetypesApp.factory ('getService', function($http) {
      //factory code
      return {
          getPhonetypes : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    phonetypesApp.factory ('postService', function($http) {
        //factory code
        return {
            postPhonetypes : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});