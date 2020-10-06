module Gofish
  class GameSerializer
    def initialize(game:)
      @game = game
    end

    def serialize
      File.write(filename, @game.to_json, mode: 'w')
    end

    def filename
      GameFilename.new(@game.deck_id).get
    end

    class << self
      def deserialize(game_id)
        filename = GameFilename.new(game_id).get

        if File.exist?(filename)
          json_string = File.read(filename)
          Game.from_json(json_string)
        end
      end
    end

    private

    class GameFilename
      def initialize(game_id)
        @game_id = game_id
      end

      def get
        "#{@game_id}.gofish"
      end
    end
  end
end
