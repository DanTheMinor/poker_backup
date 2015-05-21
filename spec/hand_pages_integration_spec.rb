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

describe("two player flop round, bb check - sb check", type: :feature) do
  it("players will cycle through flop round then move to turn") do
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
    click_button "check"
    click_button "check"
    hand = game.hands[0]
    expect(hand.cards.length).to(eq(4))
  end
end

describe("two player flop round, bb raise - sb raise", type: :feature) do
  it("players will cycle through turn round then move to river") do
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
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "call"
    click_button "check"
    click_button "check"
    hand = game.hands[0]
    expect(hand.cards.length).to(eq(5))
  end
end

describe("two player river round, bb check - sb check", type: :feature) do
  it("players will cycle through river round then move to find winner") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    click_button "call"
    click_button "check"
    click_button "check"
    click_button "check"
    click_button "check"
    click_button "check"
    click_button "check"
    click_button "check"
    hand = game.hands[0]
    expect(game.current_hand.winner_id).to be > 0
  end
end


describe("two player full game, bb raise - sb raise", type: :feature) do
  it("players will cycle through full game having a round of raises each time") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    #start pre-flop
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "call"
    #start flop
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "call"
    #start turn
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "call"
    #start River
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "call"
    expect(game.current_hand.winner_id).to be > 0
  end
end


describe("two player, sb fold", type: :feature) do
  it("test small blind fold at pre-flop") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    #start pre-flop
    click_button "fold"
    expect(game.current_hand.winner_id).to be > 0
  end
end

describe("two player, bb fold", type: :feature) do
  it("test big blind fold at pre-flop") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    #start pre-flop
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "fold"
    expect(game.current_hand.winner_id).to be > 0
  end
end


describe("two player, sb fold", type: :feature) do
  it("test small blind fold at flop") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    #start pre-flop
    click_button "call"
    click_button "check"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "fold"
    expect(game.current_hand.winner_id).to be > 0
  end
end

describe("two player, bb fold", type: :feature) do
  it("test big blind fold at flop") do
    game = Game.create(name: 'showdown')
    game.players.create(name: 'ben', stack: 200)
    game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    #start pre-flop
    click_button "call"
    click_button "check"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "fold"
    expect(game.current_hand.winner_id).to be > 0
  end
end

describe("two player, sb fold", type: :feature) do
  it("test small blind fold at turn") do
    game = Game.create(name: 'showdown')
    player1 = game.players.create(name: 'ben', stack: 200)
    player2 = game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    #start pre-flop
    click_button "call"
    click_button "check"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "call"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "fold"
    expect(game.current_hand.winner_id).to be > 0
  end
end

describe("two player, bb fold", type: :feature) do
  it("test big blind fold at turn") do
    game = Game.create(name: 'showdown')
    player1 = game.players.create(name: 'ben', stack: 200)
    player2 = game.players.create(name: 'peter', stack: 200)
    visit "/game/#{game.id}"
    click_link "Deal first hand"
    #start pre-flop
    click_button "call"
    click_button "check"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "call"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    fill_in "amount", :with => "2"
    click_button "Bet/Raise"
    click_button "fold"
    expect(game.current_hand.winner_id).to be > 0
  end
end
