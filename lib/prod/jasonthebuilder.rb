class JasonTheBuilder

		def fixture_json(team)
			fixtures = "http://api.statsfc.com/#{ENV["COMP"]}/fixtures.json?key=#{ENV["STATS_KEY"]}&team=#{team}&from=#{ENV["FROM_DATE"]}&to=#{ENV["TO_DATE"]}&timezone=#{ENV["TIMEZONE"]}&limit=#{ENV["LIMIT"]}"
			JSON.parse(HTTParty.get(fixtures).response.body)
		end

		def table_json
			table = "http://api.statsfc.com/#{ENV["COMP"]}/table.json?key=#{ENV["STATS_KEY"]}"
			JSON.parse(HTTParty.get(table).response.body)
		end


		def possession_json
			@away = Poss.pluck(:awayposs)
			@home = Poss.pluck(:homeposs)
			live_array_builder("Home Possession", "Away Possession")
		end

		def targets_json
			@away = Target.pluck(:awayshots)
			@home = Target.pluck(:homeshots)
			live_array_builder("Home Shots on Target", "Away Shots on Target")
		end

		def corners_json
			@away = Corner.pluck(:away)
			@home = Corner.pluck(:home)
			live_array_builder("Home Corners", "Away Corners")
		end

		def shots_json
			@away = Shot.pluck(:awayshots)
			@home = Shot.pluck(:homeshots)
			live_array_builder("Home Shots", "Away Shots")
		end

		def fouls_json
			@away = Foul.pluck(:away)
			@home = Foul.pluck(:home)
			live_array_builder("Home Fouls", "Away Fouls")
		end

		def live_array_builder(home, away)

			away_array = @away
			home_array = @home
			x_range = home_array.length
			x_axis_array = * 1..x_range
				
			array1 = x_axis_array.zip home_array
			array2 = x_axis_array.zip away_array		
			
			@home = array1.map do |x, y|
				{ "x"=> x, "y"=> y }
			end
			@away = array2.map do |x, y|
				{ "x"=> x, "y"=> y }
			end


			return hash_composer(home, away)
			
		end


		def hash_composer(home, away)

			jj = Hash.new {|k,v| k[v]}
			jj2 = Hash.new {|k,v| k[v]}

			jj["key"] = home
			jj["values"] = @home

			jj2["key"] = away
			jj2["values"] = @away

			final = []

			final << jj
			final << jj2

			return final

		end

		def top_scorers_json
			raw = "http://api.statsfc.com/top-scorers.json?key=#{ENV["STATS_KEY"]}&competition=#{ENV["COMP"]}&team=#{ENV["TEAM"]}&year=2013/2014"
			return HTTParty.get(raw).response.body

		end		

		def self.form(team)

			date = Date.today
			from_date = date.to_s(:db)

			future_date = date + 2.months 
			to_date = future_date.to_s(:db)

			fixtures = "http://api.statsfc.com/premier-league/fixtures.json?key=#{ENV["STATS_KEY"]}&team=#{team}&from=#{from_date}&to=#{to_date}&timezone=Europe/London&limit=5"

			teamform = "http://api.statsfc.com/premier-league/form.json?key=#{ENV["STATS_KEY"]}&team=#{team}"

			form0 = JSON.parse HTTParty.get(fixtures).response.body
			form1 = JSON.parse HTTParty.get(teamform).response.body

			away = form0.first.fetch('awaypath')
			awayname = form0.first.fetch('awayshort')

			form = []

			form1.each do |x| 
				 if x.has_value?(team)
					h = {team: team.capitalize, form: x.fetch('form')}
					form << h 
				elsif x.has_value?(away)
					h2 = {team: awayname, form: x.fetch('form')}
					form << h2
				end
			end
				form
		end

	def jason(team)

		# This code ain't DRY but it kind of just has to do one specific task 
		# that is nice to have in a controller rather than rake.
		#
		# I don't really envisage it ever being helpful to change it now.
		# 
		# I'm back a again, a week or so later and I think I need to refactor it... Genuinely didn't see this coming.
		# Very easy change

		normalized_team = team.titleize
		
		mixarray1 = Supermodel.where(:teamname => normalized_team).map(&:avgpossession)
		mixarray2 = Supermodel.where(:teamname => normalized_team).map(&:shotaccuracy)
		mixarray3 = Supermodel.where(:teamname => normalized_team).map(&:passaccuracy)
		mixarray4 = Supermodel.where(:teamname => normalized_team).map(&:attackscore)
		mixarray5 = Supermodel.where(:teamname => normalized_team).map(&:defencescore)
		mixarray6 = Supermodel.where(:teamname => normalized_team).map(&:possesionscore)
		mixarray7 = Supermodel.where(:teamname => normalized_team).map(&:optascore)
		
		length_of_models = mixarray7.length

		matchnumber = * 1..length_of_models


		barray1 = matchnumber.zip mixarray1
		barray2 = matchnumber.zip mixarray2
		barray3 = matchnumber.zip mixarray3
		barray4 = matchnumber.zip mixarray4
		barray5 = matchnumber.zip mixarray5
		barray6 = matchnumber.zip mixarray6
		barray7 = matchnumber.zip mixarray7

		newarray1 = barray1.map do |x, y|
			{ "x"=> x, "y"=> y }
		end
		newarray2 = barray2.map do |x, y|
			{ "x"=> x, "y"=> y }
		end
		newarray3 = barray3.map do |x, y|
			{ "x"=> x, "y"=> y }
		end
		newarray4 = barray4.map do |x, y|
			{ "x"=> x, "y"=> y }
		end
		newarray5 = barray5.map do |x, y|
			{ "x"=> x, "y"=> y }
		end
		newarray6 = barray6.map do |x, y|
			{ "x"=> x, "y"=> y }
		end
		newarray7 = barray7.map do |x, y|
			{ "x"=> x, "y"=> y }
		end

		jj = Hash.new {|k,v| k[v]}
		jj2 = Hash.new {|k,v| k[v]}
		jj3 = Hash.new {|k,v| k[v]}
		jj4 = Hash.new {|k,v| k[v]}
		jj5 = Hash.new {|k,v| k[v]}
		jj6 = Hash.new {|k,v| k[v]}
		jj7 = Hash.new {|k,v| k[v]}

		jj["key"] = "Average Possesion"
		jj["values"] = newarray1

		jj2["key"] = "Shot Accuracy"
		jj2["values"] = newarray2

		jj3["key"] = "Pass Accuracy"
		jj3["values"] = newarray3

		jj4["key"] = "Attack Score"
		jj4["values"] = newarray4

		jj5["key"] = "Defence Score"
		jj5["values"] = newarray5

		jj6["key"] = "Possession Score"
		jj6["values"] = newarray6

		jj7["key"] = "Opta Score"
		jj7["values"] = newarray7


		final = []

		final << jj
		final << jj2
		final << jj3
		final << jj4
		final << jj5
		final << jj6
		final << jj7


		return final

	end

end
