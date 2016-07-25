define (['angular','components/shared/index'],function(angular) {
    
   var annualagreementsApp = angular.module('annualagreementsApp', ['powerSchoolModule']);

    //annual agreements
    
   annualagreementsApp.controller ('annualagreementsCtrl', function($scope, getService, postService) {
      //controller code
      loadingDialog();
      $scope.annualagreementsList = [];
      getService.getannualagreements('annualagreements.json')
      .then(function(retData) {
         retData.pop();
         $scope.annualagreementsList = retData;
         closeLoading();
      });
      $scope.annualagreementsEdit = function(formData) {
          postService.postannualagreements('annualagreements.json', formData)
          .then(function(retData) {
              retData.pop();
              $scope.annualagreementsList = retData;
              psDialogClose();
          });
      }
   });
    
   annualagreementsApp.factory ('getService', function($http) {
      //factory code
      return {
          getannualagreements : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;                                          
              });
          }
      }
   });
    
    annualagreementsApp.factory ('postService', function($http) {
        //factory code
        return {
            postannualagreements : function(retUrl, postStr) {
                return $http.post(retUrl, postStr, {headers:{'Content-Type':'application/x-www-form-urlencoded'}})
                .then(function(postResult) {
                   return postResult.data; 
                });
            }
        }
    });

});