require 'rails_helper'

describe Contractor do
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

  describe '.import_contractors_from_csv' do
    before :each do
      Contractor.import_contractors_from_csv('spec/csv_examples/contractors.csv')
    end

    context "when csv includes an existing contractor" do
      let(:old_contractor_abn) { "456" }
      let!(:old_contractor) { create(:contractor,
                                     abn: old_contractor_abn,
                                     updated_at: 7.days.ago) }

      it "doesn’t update the existing contractor" do
        expect(
          Contractor.find_by(abn: old_contractor_abn).updated_at
        )
        .to eq old_contractor.updated_at
      end
    end

    context "when csv includes a contractor that isn't in the database" do
      let(:new_contractor) { { name: "Allens Linklaters",
                               abn: "21001295843",
                               acn: "001295843" } }

      it "creates new contractors if we don’t have them already" do
        expect(
          Contractor.find_by(abn: new_contractor[:abn]).abn
        )
        .to eq new_contractor[:abn]
      end
    end
  end
end
