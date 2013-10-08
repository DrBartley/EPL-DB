class FixturesController < ApplicationController
  before_action :set_fixture, only: [:show, :edit, :update, :destroy]
  
  FROM_DATE= Time.new.strftime("%Y-%m-%d")
  FIXTURES= "http://api.statsfc.com/#{ENV["COMP"]}/fixtures.json?key=#{ENV["STATS_KEY"]}&team=#{ENV["TEAM"]}&from=#{ENV["FROM_DATE"]}&to=#{ENV["TO_DATE"]}&timezone=#{ENV["TIMEZONE"]}&limit=#{ENV["LIMIT"]}"
  PLTABLE= "http://api.statsfc.com/#{ENV["COMP"]}/table.json?key=#{ENV["STATS_KEY"]}"
  
  def index
    gon.prematch = Prematch.all
    @home_xis = HomeXi.all
    @away_xis = AwayXi.all
    gon.form = JasonTheBuilder.new.form
    gon.d3 = JasonTheBuilder.new.jason 
    gon.liveposs = JasonTheBuilder.new.possession_json 
    gon.fixtures = JSON.parse HTTParty.get(FIXTURES).response.body
    gon.table = JSON.parse HTTParty.get(PLTABLE).response.body
  end

  def bbcjson
    render :json => BBC.new.possession
  end

  def livepossjson
    render :json => JasonTheBuilder.new.possession_json
  end  

  def liveshotjson
    render :json => JasonTheBuilder.new.shots_json
  end  

  def livetargetjson
    render :json => JasonTheBuilder.new.targets_json
  end  

  def livecornerjson
    render :json => JasonTheBuilder.new.corners_json
  end  

  def livefouljson
    render :json => JasonTheBuilder.new.fouls_json
  end

  # GET /fixtures/1
  # GET /fixtures/1.json
  def show
  end


  # GET /fixtures/new
  def new
    @fixture = Fixture.new
  end

  # GET /fixtures/1/edit
  def edit
  end

  # POST /fixtures
  # POST /fixtures.json
  def create
    @fixture = Fixture.new(fixture_params)

    respond_to do |format|
      if @fixture.save
        format.html { redirect_to @fixture, notice: 'Fixture was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fixture }
      else
        format.html { render action: 'new' }
        format.json { render json: @fixture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fixtures/1
  # PATCH/PUT /fixtures/1.json
  def update
    respond_to do |format|
      if @fixture.update(fixture_params)
        format.html { redirect_to @fixture, notice: 'Fixture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fixture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fixtures/1
  # DELETE /fixtures/1.json
  def destroy
    @fixture.destroy
    respond_to do |format|
      format.html { redirect_to fixtures_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fixture
      @fixture = Fixture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fixture_params
      params.require(:fixture).permit(:hometeam, :awayteam, :kickoff, :competition)
    end
end
