require 'rails_helper'

describe ContractorsHelper do
  describe "#simple_url" do
    it { expect(helper.simple_url("http://example.com")).to eq "example.com" }
    it { expect(helper.simple_url("http://example.com.au")).to eq "example.com.au" }
    it { expect(helper.simple_url("http://example2.com")).to eq "example2.com" }
    it { expect(helper.simple_url("https://example.com")).to eq "example.com" }
    it { expect(helper.simple_url("http://www.example.com")).to eq "example.com" }
    it { expect(helper.simple_url("http://example.com/")).to eq "example.com" }
    it { expect(helper.simple_url("http://example.com/foo")).to eq "example.com" }
    it { expect(helper.simple_url("http://example.com/foo.php")).to eq "example.com" }
    it { expect(helper.simple_url("http://example.com/foo/bar.php")).to eq "example.com" }
  end

  context "when there is one new contractor" do
    before :each do
      @contractor = create(:contractor)
      version = PaperTrail::Version.new id: 1, item_type: "Contractor", item_id: @contractor.id, event: "create"
      @versions = [version]
    end

    describe '#link_to_contractor_by_id' do
      it { expect(helper.link_to_contractor_by_id(@contractor.id)).to eq '<a href="#123">Foo Company</a>' }
      it { expect(helper.link_to_contractor_by_id(@contractor.id)).to be_html_safe }
    end

    describe "#new_contractors_sentence" do
      it { expect(helper.new_contractors_sentence(@versions)).to eq 'New contractor: <a href="#123">Foo Company</a>.'}
      it { expect(helper.new_contractors_sentence(@versions)).to be_html_safe}
    end
  end

  context "when there are two new contractors" do
    before :each do
      contractor1 = create(:contractor)
      contractor2 = create(:contractor, name: "Bar Company", abn: "456")
      version1 = PaperTrail::Version.new id: 1, item_type: "Contractor", item_id: contractor1.id, event: "create"
      version2 = PaperTrail::Version.new id: 2, item_type: "Contractor", item_id: contractor2.id, event: "create"
      @versions = [version1, version2]
    end

    describe "#new_contractors_sentence" do
      it { expect(helper.new_contractors_sentence(@versions)).to eq 'New contractors: <a href="#123">Foo Company</a> and <a href="#456">Bar Company</a>.'}
      it { expect(helper.new_contractors_sentence(@versions)).to be_html_safe}
    end
  end

  context "when there are two new contractors" do
    before :each do
      contractor1 = create(:contractor)
      contractor2 = create(:contractor, name: "Bar Company", abn: "456")
      version1 = PaperTrail::Version.new id: 1, item_type: "Contractor", item_id: contractor1.id, event: "create"
      version2 = PaperTrail::Version.new id: 2, item_type: "Contractor", item_id: contractor2.id, event: "create"
      @versions = [version1, version2]
    end

    describe "#new_contractors_sentence" do
      it { expect(helper.new_contractors_sentence(@versions)).to eq 'New contractors: <a href="#123">Foo Company</a> and <a href="#456">Bar Company</a>.'}
      it { expect(helper.new_contractors_sentence(@versions)).to be_html_safe}
    end
  end

  describe "#new_contractors_sentence" do
    before :each do
      contractor1 = create(:contractor)
      contractor2 = create(:contractor, name: "Bar Company", abn: "456")
      contractor3 = create(:contractor, name: "Wiz Company", abn: "789")
      version1 = PaperTrail::Version.new id: 1, item_type: "Contractor", item_id: contractor1.id, event: "create"
      version2 = PaperTrail::Version.new id: 2, item_type: "Contractor", item_id: contractor2.id, event: "create"
      version3 = PaperTrail::Version.new id: 3, item_type: "Contractor", item_id: contractor3.id, event: "create"
      @versions = [version1, version2, version3]
    end

    context "There are three new contractors" do
      it { expect(helper.new_contractors_sentence(@versions)).to eq 'New contractors: <a href="#123">Foo Company</a>, <a href="#456">Bar Company</a>, and <a href="#789">Wiz Company</a>.'}
      it { expect(helper.new_contractors_sentence(@versions)).to be_html_safe}
    end
  end
end
