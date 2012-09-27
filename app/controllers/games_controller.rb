class GamesController < ApplicationController

  # Show the game - this is where the game is played
  # GET /games/1
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # Start a new game
  # GET /games/new
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # Accept the details for a new game
  # POST /games
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game }
      else
        format.html { render action: "new" }
      end
    end
  end

  # Called via an AJAX method, this fires a shot and then renders an updated partial of the two boards
  # GET /games/1/fire_shot/3/4.json
  def fire_shot
    @game = Game.find(params[:game_id])
    @game.fire_shot(params[:x].to_i, params[:y].to_i)

    render :partial => 'boards', :locals => {:game => @game}
  end

end
