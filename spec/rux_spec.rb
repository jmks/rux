RSpec.describe Rux do
  describe ".rux" do
    it "returns a Regexp" do
      regexp = Rux.rux

      expect(regexp).to be_a(Regexp)
    end

    describe "building a regexp for words with length >= 3 and ending with 'at'" do
      subject(:regexp) do
        Rux.rux do
          bow
          one_or_more letters
          literal "at"
          eow
        end
      end

      it { is_expected.to match "bat" }
      it { is_expected.to match "flat" }
      it { is_expected.to_not match "map" }
      it { is_expected.to_not match "at" }
      it { is_expected.to_not match "attach" }
    end
  end
end
