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
end
