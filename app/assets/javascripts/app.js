'use strict';

var d3App = angular.module('d3App', ['nvd3ChartDirectives', 'ui.bootstrap']);

d3App.controller('AppCtrl', function AppCtrl ($scope, $http) {
	$scope.getJsons = function () {

		$http({
				method: 'GET',
				url:'/formjson/' +
					$scope.team
			}).success(function(form) {
				$scope.form = form;
		});

		$http({
				method: 'GET',
				url:'/topscorers/' +
					$scope.team
			}).success(function(topscorers) {
				$scope.topscorers = topscorers;
		});

		$http({
				method: 'GET',
				url:'/fixturesjson/' +
					$scope.team
			}).success(function(fixtures) {
				$scope.fixtures = fixtures;
			
		});	
	}

	$scope.tableJson = function () {
					
					$http({
						method: 'GET',
						url:'/tablejson/'
					}).success(function(data) {
						$scope.table = data;
				});
			}

	$scope.liveJsons = function () {
			
					$http({
						method: 'GET',
						url:'/possjson/' +
						$scope.team
					}).success(function(data) {
						$scope.liveposs = data;
				});

					$http({
						method: 'GET',
						url:'/targetjson/' +
							$scope.team
					}).success(function(data) {
						$scope.livetargets = data;
				});

					$http({
						method: 'GET',
						url:'/cornerjson/' +
							$scope.team
					}).success(function(data) {
						$scope.livecorners = data;
				});
					
					$http({
						method: 'GET',
						url:'/shotjson/' +
							$scope.team
					}).success(function(data) {
						$scope.liveshots = data;
				});
			}
			
	$scope.names = ["Arsenal", "Liverpool", "Chelsea", "Southampton", "Everton", "Hull City", "Manchester City", "Newcastle United", "Tottenham Hotspur", "West Bromwich Albion", "Cardiff City", "Swansea City", "Aston Villa", "Manchester United", "Stoke City", "Norwich City", "West Ham United", "Fulham", "Crystal Palace", "Sunderland"];

	$scope.team = 'Arsenal';

	
	$scope.colours = [
    {'Arsenal': 'red'},
    {'Chelsea': 'blue'},
    {'West Bromwich Albion': 'black'},
    {'Aston Villa': 'purple'},
    {'Liverpool': 'red'},
    {'Tottenham Hotspur': 'light grey'},
    {'Manchester United': 'red'},
    {'Stoke City': 'red'},
    {'Cardiff': 'red'},
    {'West Ham United': 'purple'},
    {'Arsenal': 'red'},
    {'Chelsea': 'blue'},
    {'Arsenal': 'red'},
    {'Chelsea': 'blue'},
    {'Arsenal': 'red'},
    {'Chelsea': 'blue'},
    {'Arsenal': 'red'},
    {'Chelsea': 'blue'},
    {'Fulham': 'black'}
  ];

	$scope.colourman = function () {
	for (var i = 0; i < ($scope.colours).length; i++) {
	  if ($scope.colours[i][$scope.team]) {
	  		$scope.myColour = $scope.colours[i][$scope.team]	
	  	} 
		}
	};

	$scope.getBadge = function () {
		$scope.badgehash = ($scope.team.replace(/ /g,"_") + ".png")
	};

	var colorArray = ['#d75054','#0080ff'];

	$scope.colorFunction = function() {
	return function(d, i) {
    	return colorArray[i];
    };
	}

	$scope.$watch('team', function(team) {
			 $scope.team = team;
			 $scope.getMegaJson();
			 $scope.liveJsons();
			 $scope.colourman();
			 $scope.getBadge();
			 $scope.getJsons()
	});

	$scope.getMegaJson = function () {
		$http({
			method: 'GET',
			url:'/megajson/' +
				$scope.team
		}).
		success(function (data) {
			$scope.megajson = data;
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
	$scope.liveJsons();
	$scope.tableJson();
});

