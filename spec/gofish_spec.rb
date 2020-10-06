require 'rack/test'
require 'gofish'
require 'rest-client'
require 'json-schema'

RSpec.describe Gofish do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'has a version number' do
    expect(Gofish::VERSION).not_to be nil
  end

  let(:body) { JSON.parse(last_response.body) }

  describe 'POST /games' do
    subject(:validator) { JSON::Validator.validate(schema, body) }
    let(:schema) do
      {
        type: :object,
        required: %i[players],
        properties: { players: { type: :array, items: { type: :string } } }
      }
    end
    let(:params) { { players: %w[xaragne boubash] } }
    before { post '/games', params }

    it { is_expected.to eq(true) }
    it { expect(last_response.status).to eq(200) }
  end

  describe 'GET games/{gameId}/players/{playerName}' do
    subject(:validator) { JSON::Validator.validate(schema, body) }

    let(:schema) do
      {
        type: :object,
        properties: {
          cards: {
            type: :array,
            items: {
              type: :object,
              properties: {
                suite: {
                  type: :string, enum: %w[hearts spades diamonds clubs]
                },
                rank: {
                  type: :string,
                  enum: %w[
                    ace
                    two
                    three
                    four
                    five
                    six
                    seven
                    eight
                    nine
                    ten
                    jack
                    queen
                    king
                  ]
                }
              }
            }
          }
        }
      }
    end
    let(:game_id) { 'vujlrdm3c6ro' }
    let(:player_name) { 'xaragne' }
    let(:route) { "/games/#{game_id}/players/#{player_name}" }
    before { get route }

    it { expect(last_response.status).to eq(200) }

    it { is_expected.to eq(true) }
  end

  describe 'POST /games/{gameId}/players/{playerName}/fish' do
    pending
  end
end
