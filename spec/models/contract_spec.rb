require 'rails_helper'

describe Contract do
  describe '.import_contracts_from_morph' do
    context 'when there is a new contract' do
      it 'creates a new contract' do
        create(:contractor, abn: '12345678901')

        VCR.use_cassette('morph_requests') do
          Contract.import_contracts_from_morph
        end

        expect(Contract.find_by(can_id: '123').can_id).to eq '123'
      end
    end

    context 'when there is an existing contract' do
      it 'updates it' do
        create(:contractor, abn: '12345678901')
        create(:contract, can_id: '123', updated_at: 7.days.ago)

        VCR.use_cassette('morph_requests') do
          Contract.import_contracts_from_morph
        end

        expect(Contract.find_by(can_id: '123').updated_at.to_date)
          .to_not eq 7.days.ago.to_date
        expect(Contract.find_by(can_id: '123').updated_at.to_date)
          .to eq Date.today
      end
    end
  end

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
