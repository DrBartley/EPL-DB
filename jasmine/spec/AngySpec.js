describe("The Colour Service", function() {
  it("should return black", function() {
    expect(team_colour("Fulham")).toBe("#000000");
    expect(team_colour("Stoke City")).toBe("#d62331");
  });
});

// describe("LiveStatsData",function(){
// 	it("returns colours correctly"
// 		LiveStatsData.colours(data, team);
// })