RSpec.describe Gofish::Game do
  let(:deck_id) { 'xyz' }
  let(:players) { %w[tom jerry] }

  let(:instance) { described_class.new(deck_id: deck_id, players: players) }

  context 'with two players' do
    let(:players) { %w[tom jerry] }

    describe 'cards per player' do
      subject { instance.cards_per_player }
      it { is_expected.to eq(7) }
    end
  end

  context 'with four + players' do
    let(:players) { %w[tom jerry, duffy, bunny] }

    describe do
      subject { instance.cards_per_player }
      it { is_expected.to eq(5) }
    end
  end

  describe '#players' do
    subject { instance.players }

    it { is_expected.to be_a(Array) }
    it { is_expected.to eq(players) }
  end

  describe '#deck_id' do
    subject { instance.deck_id }

    it { is_expected.to eq(deck_id) }
  end

  describe '#to_json' do
    subject { JSON.parse instance.to_json }

    it { is_expected.to have_key('deck_id') }
    it { is_expected.to have_key('players') }
  end

  describe '#from_json' do
    let(:json) { { players: players, deck_id: deck_id }.to_json }

    subject(:parser) { described_class.from_json(json) }

    it { is_expected.to be_a(described_class) }

    describe '#deck_id' do
      subject { parser.deck_id }

      it { is_expected.to eq(deck_id) }
    end

    describe '#players' do
      subject { parser.players }

      it { is_expected.to eq(players) }
    end
  end
end
