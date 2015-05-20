require "spec_helper"

Capybara.app = Sinatra::Application
require('./app')
set(:show_exceptions, false)

describe("the home page", type: :feature) do
  it('renders the home page') do
    visit '/'
    expect(page).to(have_content('Poker The Greatest'))
  end
end

describe("starting a game", type: :feature) do
  it('renders adding player page and displays game name') do
    visit '/'
    fill_in 'game_name', with: 'showdown'
    click_button 'Start game'
    expect(page).to(have_content('showdown'))
  end

  it('adds a player to a game when the player add form is submitted') do
    game = Game.create(name: 'showdown')
    visit "/game/#{game.id}"
    fill_in("name", with: "ben")
    click_button("Add Player")
    expect(page).to(have_content("ben"))
  end
end
