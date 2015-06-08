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

  describe "#new_contractors_sentence" do
    let!(:contractor1) { Contractor.create id: 1, name: "Foo Company", abn: "123" }
    let!(:contractor2) { Contractor.create id: 2, name: "Bar Company", abn: "456" }
    let!(:contractor3) { Contractor.create id: 3, name: "Wiz Company", abn: "789" }
    let(:version1) { PaperTrail::Version.new id: 1, item_type: "Contractor", item_id: 1, event: "create" }
    let(:version2) { PaperTrail::Version.new id: 2, item_type: "Contractor", item_id: 2, event: "create" }
    let(:version3) { PaperTrail::Version.new id: 3, item_type: "Contractor", item_id: 3, event: "create" }

    context "There is one new contractor" do
      let(:versions) {[version1]}
      it { expect(helper.new_contractors_sentence(versions)).to eq "1 new contractor <em>Foo Company</em> added."}
    end

    context "There are two new contractors" do
      let(:versions) {[version1, version2]}
      it { expect(helper.new_contractors_sentence(versions)).to eq "2 new contractors <em>Foo Company</em> and <em>Bar Company</em> added."}
    end

    context "There are three new contractors" do
      let(:versions) {[version1, version2, version3]}
      it { expect(helper.new_contractors_sentence(versions)).to eq "3 new contractors <em>Foo Company</em>, <em>Bar Company</em>, and <em>Wiz Company</em> added."}
    end
  end
end
