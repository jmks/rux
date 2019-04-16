require "spec_helper"

module Rux
  RSpec.describe Builder do
    describe "#word_start" do
      it "adds a word boundary" do
        builder = Builder.new do
          word_start
        end

        regexp = builder.build

        expect(regexp.source).to eq "\\b"
      end
    end

    describe "#one_or_more" do
      context "given a string" do
        it "adds a plus" do
          builder = Builder.new do
            one_or_more "a"
          end

          regexp = builder.build

          expect(regexp.source).to eq "a+"
        end
      end
    end

    describe "#literal" do
      it "adds a literal string" do
        builder = Builder.new do
          literal "a"
        end

        regexp = builder.build

        expect(regexp.source).to eq "a"
      end

      it "escapes special values" do
        builder = Builder.new do
          literal "\*?{}."
        end

        regexp = builder.build

        expect(regexp.source).to eq "\\*\\?\\{\\}\\."
      end
    end
  end
end
