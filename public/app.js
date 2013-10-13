'use strict';


var d3App = angular.module('d3App', [ 'n3-charts.linechart' ]);


d3App.controller('AppCtrl', function AppCtrl ($scope, $http) {


  $scope.team = 'arsenal';

   $scope.$watch('team', function(team) {
       $scope.team = team;
       $scope.getMegaJson()
  });
  $scope.options = {
    lineMode: "cardinal",
    series: [
      {y: "avg_poss", label: "Avg. Possession", color: "#bcbd22"},
      {y: "shot_acc", label: "Shot Accuracy", color: "#17becf"},
      {y: "pass_acc", label: "Pass Accuracy", color: "#1467bd"},
      {y: "def_score", label: "Defensive Score", color: "#9467bd"},
      {y: "att_score", label: "Attack Score", color: "#9222bd"},
      {y: "opta_score", label: "Opta Score", color: "#9222bd"},
      {y: "poss_score", label: "Possession Score", color: "#4222bd"},
    ],
    axes: {
      x: {type: "linear", key: "x"},
      y: {type: "linear"}
    },
    tooltipMode: "default"
  };

  $scope.getMegaJson = function () {
    $http({
      method: 'GET',
      url:'/megajson/' +
        $scope.team
    }).
    success(function (data) {
      $scope.data = data;
      $scope.error = '';
    }).
    error(function (data, status) {
      if (status === 404) {
        $scope.error = 'Not found?';
      } else {
        $scope.error = 'Error: ' + status;
      }
    });
  };
  
  $scope.getMegaJson();
});

