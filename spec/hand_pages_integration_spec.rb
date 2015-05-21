require "spec_helper"

Capybara.app = Sinatra::Application
require('./app')
set(:show_exceptions, false)

describe("dealing the first cards in a hand", type: :feature) do
  it("deals players' hole cards") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    expect(page).to(have_content('ben'))
    expect(page).to(have_content('peter'))
  end
end


describe("small blind player calls", type: :feature) do
  it("accepts SB user request to call in pre-flop") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    click_button "call"
    expect(page).to(have_content('ben : stack 198'))
  end
end


describe("small blind player bets/raises", type: :feature) do
  it("accepts SB user request to bet/raise in preflop") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    expect(page).to(have_content('ben : stack  197'))
  end
end

describe("two player pre-flop round, call check only", type: :feature) do
  it("players will cycle through pre-flop round then move to flop") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    click_button "call"
    click_button "check"
    hand = game.hands[0]
    expect(hand.cards).to exist
    expect(hand.cards.length).to(eq(3))
  end
end

describe("two player pre-flop round, SB bet/raise - BB bet/raise", type: :feature) do
  it("players will cycle through pre-flop round then move to flop") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "call"
    hand = game.hands[0]
    expect(hand.cards).to exist
    expect(hand.cards.length).to(eq(3))
  end
end
