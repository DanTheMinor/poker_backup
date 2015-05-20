require('bundler/setup')
Bundler.require(:default, :production)
require "pry"
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

get "/" do
  erb :index
end

post "/start_game" do
  game_name = params.fetch("game_name")
  game = Game.create(name: game_name)
  redirect "/game/#{game.id}"
end

get "/game/:id" do |id|
  @game = Game.find(id)
  erb(:add_players)
end

post "/add_player" do
  name= params.fetch("name")
  game_id = params.fetch("game_id").to_i
  game = Game.find(game_id)
  #will need to set stack for player
  game.players.create(name: name)
  redirect "/game/#{game.id}"
end

get "/game/:id/preflop" do |id|
  @game = Game.find(id)
  @game.players.each do |player|
    @game.deal(player)
  end
  @player1 = @game.players[0]
  @player2 = @game.players[1]
  erb(:hand)
end
