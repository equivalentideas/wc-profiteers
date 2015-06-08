require 'rails_helper'

describe ContractsHelper do
  context 'There is one contract' do
    let!(:contract1) { Contract.create id: 1, description: "Foo Service", can_id: "123" }

    describe "#link_to_contract_by_id" do
      let(:id) {1}
      it { expect(helper.link_to_contract_by_id(id)).to eq '<a href="#123">Foo Service</a>' }
      it { expect(helper.link_to_contract_by_id(id)).to be_html_safe }
    end
  end
end
