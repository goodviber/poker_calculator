class CheatingError < StandardError
  def initialize(msg="Someone is cheating!")
    super
  end
end
