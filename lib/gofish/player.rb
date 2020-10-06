module Gofish
  class Player
    attr_reader :name, :cards

    def initialize(name:, cards:)
      @name, @cards = name, cards
    end
  end
end
