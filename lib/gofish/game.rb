require 'singleton'

module Gofish
  class Game
    attr_reader :cards_per_player
    attr_accessor :deck_id, :players

    def initialize(deck_id:, players:)
      @deck_id, @players = deck_id, players

      @cards_per_player = players.length >= 4 ? 5 : 7
    end

    def submit_to_api!
      result =
        RestClient.get(
          'https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1'
        )

      if result.code.eql?(200)
        json = JSON.parse(result.body)
        self.deck_id = json.fetch('deck_id')

        true
      else
        false
      end
    end

    def distribute_cards!
      result =
        RestClient.get(
          "https://deckofcardsapi.com/api/deck/#{deck_id}/draw/?count=#{
            cards_to_fetch
          }"
        )

      if result.code.eql?(200)
        cards = JSON.parse(result.body)
        puts(cards)
        cards = cards.fetch('cards').each_slice(@cards_per_player) { |c| c }
        cards ||= []
        cards.each_with_index do |cards_slice, index|
          players[index].cards = cards_slice
        end
      else

      end
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

    private

    def cards_to_fetch
      @cards_per_player * players.count
    end
  end
end
