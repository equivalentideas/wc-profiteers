require 'rails_helper'

describe Contract do
  let!(:contract) { Contract.create id: 1, can_id: '123' }

  context 'description starts with no caps "westconnex - "' do
    before :each do
      contract.update description: 'westconnex - Foo Service'
    end

    it '#display_description' do
      expect(contract.display_description).to eq 'Foo Service'
    end
  end

  context 'description starts with capticalised "WestConnex - "' do
    before :each do
      contract.update description: 'WestConnex - Foo Service'
    end

    it '#display_description' do
      expect(contract.display_description).to eq 'Foo Service'
    end
  end

  context 'description starts with "WDA - "' do
    before :each do
      contract.update description: 'WDA - Foo Service'
    end

    it '#display_description' do
      expect(contract.display_description).to eq 'Foo Service'
    end
  end

  context 'description contains but doesnt start with "WestConnex - "' do
    before :each do
      contract.update description: 'Foo Service WestConnex - '
    end

    it '#display_description' do
      expect(contract.display_description).to eq 'Foo Service WestConnex - '
    end
  end

  context 'description does not contain "WestConnex - " or "WDA - "' do
    before :each do
      contract.update description: 'Foo Service'
    end

    it '#display_description' do
      expect(contract.display_description).to eq 'Foo Service'
    end
  end
end
