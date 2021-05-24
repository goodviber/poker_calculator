class Analyser

  def initialize(players_hands)
    @players_hands = players_hands
    validate!
  end

  def call
    result = @players_hands.each_line.map{ |line| Hand.new(line) }
    result.sort.reverse.each { |hand| puts "#{hand}\t #{hand.rank}" }
  end

  private

  def validate!
    hands_array = @players_hands.split(/\W+/)
    unique_count = hands_array.uniq.size
    raise CheatingError unless unique_count == hands_array.size
    # I think a duplicate card covers all cases of extra cards ?
    #raise CheatingError, "2" if hands_array.detect{ |e| hands_array.count(e) > 1 }

    #numbers_only = hands_array.map{ |e| e.gsub(/[hdcs]+/, '') }
    #raise CheatingError, "3" if numbers_only.detect{ |e| hands_array.count(e) > 4 }
  end

end
