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
  game.players.create(name: name, stack: 200)
  redirect "/game/#{game.id}"
end

get "/game/:id/preflop" do |id|
  game = Game.find(id)
  game.new_hand
  redirect "/game/#{id}/hand"
end

get "/game/:id/hand" do |id|
  @game = Game.find(id)
  @player1 = @game.players.sort_by {|player| player.id}.first
  @player2 = @game.players.sort_by {|player| player.id}.last
  erb(:hand)
end

post "/game/:id/postflop" do |id|
  game = Game.find(id)
  game.current_hand.flop_deal
  redirect "/game/#{game.id}/hand"
end

post "/game/:id/:choice" do |id, choice|
  game = Game.find(id)
  current_player = game.current_player

  unless choice == "fold" || choice == "check"
    amount = params["amount"].to_i
    current_player.update_amounts(choice, amount)
  end
  current_player.update(choice: choice)

  other_player = game.other_player
  game.current_hand.handle_choice(current_player, other_player)
  redirect "/game/#{id}/hand"
end
