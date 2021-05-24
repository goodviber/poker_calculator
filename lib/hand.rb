class Hand
  include Comparable
  attr_reader :cards, :rank

  RANKS       = %i(high-card one-pair two-pair three-of-a-kind straight flush
                   full-house four-of-a-kind straight-flush five-of-a-kind)
  WHEEL_FACES = %i(2 3 4 5 a)

  def initialize(str_of_cards)
    @cards = str_of_cards.downcase.tr(',',' ').split.map{|str| Card.new(str)}
    grouped = @cards.group_by(&:face).values
    @face_pattern = grouped.map(&:size).sort
    @rank = categorize
    @rank_num = RANKS.index(@rank)
    @tiebreaker = grouped.map{|ar| [ar.size, ar.first.ordinal]}.sort.reverse

    validate!
  end

  def <=> (other)
    self.compare_value <=> other.compare_value
  end

  def to_s
    @cards.map(&:to_s).join(" ")
  end

  protected

  def compare_value
    [@rank_num, @tiebreaker]
  end

  private

  def validate!
    raise ArgumentError, "expected 5 cards, got #{@cards.size}" unless @cards.size == 5
    raise CheatingError unless self.to_s.split(/\W+/).uniq.size == 5
  end

  def one_suit?
    @cards.map(&:suit).uniq.size == 1
  end

  def consecutive?
    sort.each_cons(2).all? {|c1,c2| c2.ordinal - c1.ordinal == 1 }
  end

  def sort
    if @cards.sort.map(&:face) == WHEEL_FACES
      @cards.detect {|c| c.face == :a}.ordinal = -1
    end
    @cards.sort
  end

  def categorize
    if consecutive?
      one_suit? ? :'straight-flush' : :straight
    elsif one_suit?
      :flush
    else
      case @face_pattern
        when [1,1,1,1,1] then :'high-card'
        when [1,1,1,2]   then :'one-pair'
        when [1,2,2]     then :'two-pair'
        when [1,1,3]     then :'three-of-a-kind'
        when [2,3]       then :'full-house'
        when [1,4]       then :'four-of-a-kind'
        when [5]         then :'five-of-a-kind'
      end
    end
  end
end
