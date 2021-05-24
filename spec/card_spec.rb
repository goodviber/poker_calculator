require 'spec_helper'

describe Card do
  let(:card1) { Card.new("2h") }
  let(:card2) { Card.new("3d") }
  let(:card3) { Card.new("3s") }

  it "returns the face value" do
    expect(card1.face).to eq(:"2")
  end

  it "returns the suit" do
    expect(card1.suit).to eq(:h)
  end

  it "returns the ordinal index" do
    expect(card1.ordinal).to eq(0)
    expect(card2.ordinal).to eq(1)
  end

  it "compares the card values" do
    expect(card1 <=> card2).to eq(-1)
    expect(card2 <=> card1).to eq(1)
    expect(card2 <=> card3).to eq(0)
  end

  it "checks for invalid cards" do
    expect{ Card.new("D1") }.to raise_error(ArgumentError)
  end

end
