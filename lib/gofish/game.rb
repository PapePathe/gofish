require 'singleton'

module Gofish
  class Game
    attr_accessor :deck_id, :players

    def initialize(deck_id:, players:)
      @deck_id, @players = deck_id, players
    end

    def to_json
      { deck_id: deck_id, players: players }.to_json
    end

    class << self
      def from_json(json)
        data = JSON.parse(json)
        new(deck_id: data.fetch('deck_id'), players: data.fetch('players'))
      end
    end
  end
end
