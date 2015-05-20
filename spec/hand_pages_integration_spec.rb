require "spec_helper"

Capybara.app = Sinatra::Application
require('./app')
set(:show_exceptions, false)

describe("dealing the first cards in a hand", type: :feature) do
  it("deals players' hole cards") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben')
    game.players.create(name: 'peter')
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    expect(page).to(have_content('ben'))
    expect(page).to(have_content('peter'))
  end
end
