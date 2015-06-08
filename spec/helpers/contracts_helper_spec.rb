require 'rails_helper'

describe ContractsHelper do
  context 'There is one contract' do
    let!(:contract1) { Contract.create id: 1, description: 'Foo Service', can_id: '123' }

    describe '#link_to_contract_by_id' do
      let(:id) {1}
      it { expect(helper.link_to_contract_by_id(id)).to eq '<a href="#123">Foo Service</a>' }
      it { expect(helper.link_to_contract_by_id(id)).to be_html_safe }
    end
  end

  describe '#new_contracts_sentence' do
    let!(:contract1) { Contract.create id: 1, description: 'Foo Service', can_id: '123' }
    let!(:contract2) { Contract.create id: 2, description: 'Bar Service', can_id: '456' }
    let!(:contract3) { Contract.create id: 3, description: 'Wiz Service', can_id: '789' }
    let(:version1) { PaperTrail::Version.new id: 1, item_type: 'Contract', item_id: 1, event: 'create' }
    let(:version2) { PaperTrail::Version.new id: 2, item_type: 'Contract', item_id: 2, event: 'create' }
    let(:version3) { PaperTrail::Version.new id: 3, item_type: 'Contract', item_id: 3, event: 'create' }

    context 'there is one new contract' do
      let(:versions) {[version1]}
      it { expect(helper.new_contracts_sentence(versions)).to eq 'New contract <a href="#123">Foo Service</a> added.'}
      it { expect(helper.new_contracts_sentence(versions)).to be_html_safe }
    end

    context 'there are two new contracts' do let(:versions) {[version1, version2]}
      it { expect(helper.new_contracts_sentence(versions)).to eq 'New contracts <a href="#123">Foo Service</a> and <a href="#456">Bar Service</a> added.'}
      it { expect(helper.new_contracts_sentence(versions)).to be_html_safe }
    end

    context 'there are three new contracts' do let(:versions) {[version1, version2, version3]}
      it { expect(helper.new_contracts_sentence(versions)).to eq 'New contracts <a href="#123">Foo Service</a>, <a href="#456">Bar Service</a>, and <a href="#789">Wiz Service</a> added.'}
      it { expect(helper.new_contracts_sentence(versions)).to be_html_safe }
    end
  end
end
