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
end
