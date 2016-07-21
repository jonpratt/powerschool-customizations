define (['angular','components/shared/index'],function(angular) {
    var commservApp = angular.module('commservApp', ['powerSchoolModule']);
    commservApp.controller('commservAppCtrl', function($scope, getService) {
            loadingDialog();
            $scope.commservList = [];
            getService.getCS('commserveval.json').then(function(retData) {
                retData.pop();
                $scope.commservList = retData;
                closeLoading();
            });
    });
    
    commservApp.factory ('getService', function($http) {
      //factory code
      return {
          getCS : function(dataFile) {
              return $http.get(dataFile)
              .then(function(result) {
                return result.data;      
              });
          }
      }
    });
});