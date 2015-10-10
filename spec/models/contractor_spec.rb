require 'rails_helper'

describe Contractor do
  before :each do
    @contractor = create(:contractor)
  end

  context 'has an ABN but no ACN' do
    before :each do
      @contractor.update abn: '123'
    end

    it '#corporate_id' do
      expect(@contractor.corporate_id).to eq '123'
    end
  end

  context 'has an ACN but no ABN' do
    before :each do
      @contractor.update acn: '456'
    end

    it '#corporate_id' do
      expect(@contractor.corporate_id).to eq '456'
    end
  end

  context 'has an ACN and ABN' do
    before :each do
      @contractor.update abn: '123', acn: '456'
    end

    it '#corporate_id' do
      expect(@contractor.corporate_id).to eq '456'
    end
  end

  context 'has no ACN or ABN' do
    before :each do
      @contractor.update abn: nil, acn: nil
    end

    it '#corporate_id' do
      expect(@contractor.corporate_id).to eq "no_corporate_id_#{@contractor.id}"
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
