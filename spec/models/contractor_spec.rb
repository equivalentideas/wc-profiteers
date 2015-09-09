require 'rails_helper'

describe Contractor do
  let!(:contractor) { Contractor.create id: 1 }

  context 'has an ABN but no ACN' do
    before :each do
      contractor.update abn: '123'
    end

    it '#corporate_id' do
      expect(contractor.corporate_id).to eq '123'
    end
  end

  context 'has an ACN but no ABN' do
    before :each do
      contractor.update acn: '456'
    end

    it '#corporate_id' do
      expect(contractor.corporate_id).to eq '456'
    end
  end

  context 'has an ACN and ABN' do
    before :each do
      contractor.update abn: '123', acn: '456'
    end

    it '#corporate_id' do
      expect(contractor.corporate_id).to eq '456'
    end
  end

  context 'has no ACN or ABN' do
    it '#corporate_id' do
      expect(contractor.corporate_id).to eq 'no_corporate_id_1'
    end
  end

  describe '.import_contractors_from_csv' do
    before :each do
      csv_path = 'spec/csv_examples/contractors.csv'

      Contractor.import_contractors_from_csv(csv_path)
    end

    context "when csv includes a contractor that isn't in the database" do
      new_contractor = {
        name: "Allens Linklaters",
        abn: "21001295843",
        acn: "001295843"
      }

      it "creates new contractors if we don’t have them already" do
        expect(
          Contractor.find_by(abn: new_contractor[:abn]).name
        )
        .to eq new_contractor[:name]
      end
    end

    context "when csv includes an existing contractor" do
      old_contractor_abn = "50098008818"
      old_contractor = Contractor.create id: 2, name: "ADVISIAN PTY LTD", abn: old_contractor_abn, updated_at: 7.days.ago

      it "doesn’t update the existing contractor" do
        expect(
          Contractor.find_by(abn: old_contractor_abn).updated_at.to_date
        )
        .to eq 7.days.ago.to_date
      end
    end
  end
end
