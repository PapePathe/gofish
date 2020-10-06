require 'gofish/game_serializer'

RSpec.describe Gofish::GameSerializer do
  let(:deck_id) { 'xyz' }
  let(:players) { %w[xaragne boubash] }
  let(:game) { Gofish::Game.new(**params) }
  let(:instance) { described_class.new(game: game) }
  let(:params) { { "deck_id": deck_id, "players": players } }

  describe '#serialize' do
    before { instance.serialize }
    let(:json_text) { File.read(instance.filename) }
    let(:json) { JSON.parse json_text }

    it { expect(json['deck_id']).to eq(deck_id) }
    it { expect(json['players']).to eq(players) }
  end

  describe '#deserialize' do
    before { instance.serialize }
    let(:deserialized) { described_class.deserialize(deck_id) }

    describe 'has same deck_id' do
      subject { deserialized.deck_id }

      it { is_expected.to eq(deck_id) }
    end

    describe 'has same players' do
      subject { deserialized.players }

      it { is_expected.to eq(players) }
    end

    describe 'is a game' do
      subject { deserialized }

      it { is_expected.to be_a(Gofish::Game) }
    end
  end
end
