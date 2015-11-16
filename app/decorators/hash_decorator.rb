class HashDecorator
  def initialize
    @hash = {}
  end

  def array_as_default
    @hash.default = Array.new
  end
end