class Website

  attr_accessor :name, :url, :rank

  def initialize(name, url, rank)
    @name, @url, @rank = name, url, rank.to_i
  end
end
