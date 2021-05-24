require 'spec_helper'

describe Analyser do
  subject { described_class.new }
  let(:duplicate) { Analyser.new(File.read("spec/fixtures/files/duplicate_cards.txt")) }
  let(:valid) { Analyser.new(File.read("spec/fixtures/files/valid_cards.txt")) }

  it "validates the players hands" do
    expect{ duplicate }.to raise_error(CheatingError)
    expect{ valid }.to_not raise_error
  end

  it "values the hands correctly" do
    expect{ valid.call }.to output(/10c jc qc kc ac\t straight-flush\n10h jh qh kh ah\t straight-flush\n5h 6h 7h 8h 9h\t straight-flush\n5d 6d 8d 9d 10d\t flush\n2s 3s 4s 2c 3c\t two-pair\n2h 3h 2d 3d 4d\t two-pair\n7s 7c jd qd kd\t one-pair\n5s 6s 4c 5c ad\t one-pair/).to_stdout
  end
end
