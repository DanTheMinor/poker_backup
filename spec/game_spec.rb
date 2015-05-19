require 'spec_helper'

describe(Game) do
  it('populates card database') do
    Game.create()
    expect(Card.all.length).to(eq(52))
  end

  it('populates card database with cards with suits') do
    Game.create()
    expect(Card.all.first.suit).to(eq('s'))
  end

  it('populates card database with cards with values') do
    Game.create()
    expect(Card.all.first.value).to(eq('2'))
  end

  it('populates card database with cards with picture urls') do
    Game.create()
    expect(Card.all.first.url).to(eq('2s.jpg'))
  end


end
