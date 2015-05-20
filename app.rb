require('bundler/setup')
Bundler.require(:default, :production)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

get "/" do
  erb :index
end

post "/start_game" do
  game_name = params.fetch("game_name")
  @game = Game.create(name: game_name)
  erb(:add_players)
end

get "/preflop" do

end
