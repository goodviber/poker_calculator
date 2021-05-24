class Card
  include Comparable
  attr_accessor :ordinal
  attr_reader :suit, :face

  SUITS = %i(h d s c)
  FACES = %i(2 3 4 5 6 7 8 9 10 j q k a)

  def initialize(str)
    @face, @suit = parse(str)
    @ordinal = FACES.index(@face)
  end

  def <=> (other)
    self.ordinal <=> other.ordinal
  end

  def to_s
    "#@face#@suit"
  end

  private
  def parse(str)
    face, suit = str.chop.to_sym, str[-1].to_sym
    raise ArgumentError, "invalid card: #{str}" unless FACES.include?(face) && SUITS.include?(suit)
    [face, suit]
  end
end


