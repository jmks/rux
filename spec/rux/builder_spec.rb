require "spec_helper"

module Rux
  RSpec.describe Builder do
    describe "#word_start" do
      it "adds a word boundary" do
        builder = Builder.new do
          word_start
        end

        expect(builder).to build_regex "\\b"
      end
    end

    describe "#one_or_more" do
      context "given a string" do
        it "adds a plus" do
          builder = Builder.new do
            one_or_more "a"
          end

          expect(builder).to build_regex "a+"
        end
      end
    end

    describe "#literal" do
      it "adds a literal string" do
        builder = Builder.new do
          literal "a"
        end

        expect(builder).to build_regex "a"
      end

      it "escapes special values" do
        builder = Builder.new do
          literal "\*?{}."
        end

        expect(builder).to build_regex "\\*\\?\\{\\}\\."
      end
    end

    describe "convenience groups" do
      specify "#letters to match a-zA-Z" do
        expect(Builder.new.letters).to eq "[a-zA-Z]"
      end

      specify "#numbers to match 0-9" do
        expect(Builder.new.numbers).to eq "[0-9]"
      end

      specify "#whitespace to match \s" do
        expect(Builder.new.whitespace).to eq "\s"
      end
    end
  end
end
