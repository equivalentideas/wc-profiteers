require 'rails_helper'

describe Contractor do
  describe '.import_contractors_from_csv' do
    context 'when csv includes a new contractor' do
      before { Contractor.import_contractors_from_csv('spec/csv_examples/contractors.csv') }

      it 'creates new contractors if we don’t have them already' do
        new_contractor_abn = '1234567890'

        expect(Contractor.find_by(abn: new_contractor_abn).abn).to eq new_contractor_abn
      end
    end

    context 'when csv includes an existing contractor' do
      before :each do
        @old_contractor_abn = '1234567890'
        create(:contractor, abn: @old_contractor_abn, updated_at: 7.days.ago)

        Contractor.import_contractors_from_csv('spec/csv_examples/contractors.csv')
      end

      it 'doesn’t update the existing contractor' do
        expect(Contractor.find_by(abn: @old_contractor_abn).updated_at.to_date)
          .to eq 7.days.ago.to_date
      end
    end
  end

  describe '#corporate_id' do
    context 'when there is a contractor with an ABN but no ACN' do
      let(:contractor) { FactoryGirl.create(:contractor, abn: '123', acn: nil) }

      it 'is the ABN' do
        expect(contractor.corporate_id).to eq '123'
      end
    end

    context 'when there is a contractor with an ACN and an ABN' do
      let(:contractor) { FactoryGirl.create(:contractor, abn: '123', acn: '456') }

      it 'is the ACN' do
        expect(contractor.corporate_id).to eq '456'
      end
    end
  end
end
