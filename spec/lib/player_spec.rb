RSpec.describe Gofish::Player do
  let(:name) { 'xaragne' }
  let(:cards) { [] }
  let(:instance) { described_class.new(name: name, cards: cards) }

  describe '#name' do
    subject { instance.name }

    it { is_expected.to eq(name) }
  end

  describe '#cards' do
    subject { instance.cards }

    it { is_expected.to eq(cards) }
  end
end
