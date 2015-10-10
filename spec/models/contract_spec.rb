require 'rails_helper'

describe Contract do
  describe '#display_description' do
    context 'description starts with no caps "westconnex - "' do
      let(:contract) { create(:contract, description: 'westconnex - Foo Service') }

      it { expect(contract.display_description).to eq 'Foo Service' }
    end

    context 'description starts with capticalised "WestConnex - "' do
      let(:contract) { create(:contract, description: 'WestConnex - Foo Service') }

      it { expect(contract.display_description).to eq 'Foo Service' }
    end

    context 'description starts with "WDA - "' do
      let(:contract) { create(:contract, description: 'WDA - Foo Service') }

      it { expect(contract.display_description).to eq 'Foo Service' }
    end

    context 'description contains but doesnt start with "WestConnex - "' do
      let(:contract) { create(:contract, description: 'Foo Service WestConnex - ') }

      it { expect(contract.display_description).to eq 'Foo Service WestConnex - ' }
    end

    context 'description does not contain "WestConnex - " or "WDA - "' do
      let(:contract) { create(:contract, description: 'Foo Service') }

      it { expect(contract.display_description).to eq 'Foo Service' }
    end
  end
end
