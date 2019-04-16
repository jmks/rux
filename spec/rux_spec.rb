RSpec.describe Rux do
  describe ".rux" do
    it "returns a Regexp" do
      regexp = Rux.rux

      expect(regexp).to be_a(Regexp)
    end
  end
end
