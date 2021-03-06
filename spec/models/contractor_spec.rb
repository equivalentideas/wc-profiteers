require 'rails_helper'

describe Contractor do
  describe '.import_contractors_from_morph' do
    context 'when there is a new contractor' do
      it 'creates a new contractor' do
        VCR.use_cassette('morph_requests') do
          Contractor.import_contractors_from_morph
        end

        expect(Contractor.find_by(abn: '76128188714').name)
          .to eq 'INFRASOL GROUP PTY LIMITED'
      end
    end

    context 'when there is a specific contractor' do
      it 'adds them as a new contractor' do
        VCR.use_cassette('morph_requests') do
          Contractor.import_contractors_from_morph
        end

        expect(Contractor.find_by(abn: '93690339855').name).to eq 'PEARL, JOSHUA'
      end
    end

    context 'when there is an existing contractor' do
      before :each do
        Timecop.freeze(Time.local(2015, 10, 12, 12, 0, 0))

        create(:contractor, abn: '93690339855', updated_at: 7.days.ago)
      end

      after do
        Timecop.return
      end

      it 'updates it' do
        VCR.use_cassette('morph_requests') do
          Contractor.import_contractors_from_morph
        end

        expect(Contractor.find_by(abn: '93690339855').updated_at.to_date)
          .to_not eq 7.days.ago.to_date
        expect(Contractor.find_by(abn: '93690339855').updated_at.to_date)
          .to eq Date.today
      end
    end
  end

  describe '.import_contractors_from_csv' do
    context 'when csv includes a new contractor' do
      before { Contractor.import_contractors_from_csv('spec/fixtures/csv_examples/contractors.csv') }

      it 'creates new contractors if we don’t have them already' do
        new_contractor_abn = '1234567890'

        expect(Contractor.find_by(abn: new_contractor_abn).abn).to eq new_contractor_abn
      end
    end

    context 'when csv includes an existing contractor' do
      before :each do
        @old_contractor_abn = '1234567890'
        create(:contractor, abn: @old_contractor_abn, updated_at: 7.days.ago)

        Contractor.import_contractors_from_csv('spec/fixtures/csv_examples/contractors.csv')
      end

      it 'doesn’t update the existing contractor' do
        expect(Contractor.find_by(abn: @old_contractor_abn).updated_at.to_date)
          .to eq 7.days.ago.to_date
      end
    end
  end

  describe '#total_est_contract_value' do
    context 'when the contractor has no contracts' do
      it 'has 0 total value' do
        contractor = create(:contractor)

        expect(contractor.total_est_contract_value).to eq 0
      end

    end

    context 'when the contractor has contracts' do
      it 'has is the sum of their value' do
        contractor = create(:contractor)
        create(:contract, contractor_id: contractor.id, value: 1)
        create(:contract, contractor_id: contractor.id, value: 1)
        create(:contract, contractor_id: contractor.id, value: 1)

        expect(contractor.total_est_contract_value).to eq 3.0
      end
    end
  end

  describe '#corporate_id' do
    context 'when there is a contractor with an ABN but no ACN' do
      let(:contractor) { FactoryBot.create(:contractor, abn: '123', acn: nil) }

      it 'is the ABN' do
        expect(contractor.corporate_id).to eq '123'
      end
    end

    context 'when there is a contractor with an ACN and an ABN' do
      let(:contractor) { FactoryBot.create(:contractor, abn: '123', acn: '456') }

      it 'is the ACN' do
        expect(contractor.corporate_id).to eq '456'
      end
    end
  end
end
