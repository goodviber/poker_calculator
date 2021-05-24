require 'spec_helper'

describe Hand do
  let(:hand1) { Hand.new("2h 2d 3c 7s qh") }
  let(:hand2) { Hand.new("5c 5h 5d 8s 9h") }
  let(:hand3) { Hand.new("ad 3d 4d 6d qd") }
  let(:hand4) { Hand.new("2s 2c 3h 7h qc") }
  let(:hand5) { Hand.new("ac jc qc kc 10c") }
  let(:hand6) { Hand.new("ac as ad ah 7h") }
  let(:hand7) { Hand.new("ac 2s 2c ah ad") }
  let(:too_many_cards) { Hand.new("ac 2s 2c 3h 7h qc") }
  let(:not_unique_cards) { Hand.new("ac ac 2s 3d 4h")}

  it "returns the cards" do
    expect(hand1.cards[0]).to be_a(Card)
  end

  it "returns the rank" do
    expect(hand1.rank).to eq :"one-pair"
    expect(hand2.rank).to eq :"three-of-a-kind"
    expect(hand3.rank).to eq :"flush"
    expect(hand4.rank).to eq :"one-pair"
    expect(hand5.rank).to eq :"straight-flush"
    expect(hand6.rank).to eq :"four-of-a-kind"
    expect(hand7.rank).to eq :"full-house"
  end

  it "compares the ranks" do
    expect(hand1 <=> hand2).to eq -1
    expect(hand2 <=> hand3).to eq -1
    expect(hand1 <=> hand4).to eq 0
  end

  it "checks the hand size" do
    expect{ too_many_cards }.to raise_error(ArgumentError)
    expect{ not_unique_cards }.to raise_error(CheatingError)
  end
end
