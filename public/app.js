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
	};

	$scope.tableJson = function () {
					$http({
						method: 'GET',
						url:'/tablejson/'
					}).success(function(data) {
						$scope.table = data;
				});
			}

	$scope.livePossJson = function () {
					$http({
						method: 'GET',
						url:'/livepossjson-v2/'
					}).success(function(data) {
						$scope.liveposs = data;
				});
			}

	$scope.liveTargetsJson = function () {
					$http({
						method: 'GET',
						url:'/livetargetsjson-v2/'
					}).success(function(data) {
						$scope.livetargets = data;
				});
			}
			
	$scope.names = ["Arsenal", "Liverpool", "Chelsea", "Southampton", "Everton", "Hull City", "Manchester City", "Newcastle United", "Tottenham Hotspur", "West Bromwich Albion", "Cardiff City", "Swansea City", "Aston Villa", "Manchester United", "Stoke City", "Norwich City", "West Ham United", "Fulham", "Crystal Palace", "Sunderland"];

	$scope.team = 'Arsenal';

	$scope.$watch('team', function(team) {
			 $scope.team = team;
			 $scope.getMegaJson();
			 $scope.getJsons()
	});

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

	$scope.livePossJson();
	$scope.liveTargetsJson();
	$scope.tableJson();
});

