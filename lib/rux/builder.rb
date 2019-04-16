module Rux
  # Builder collects the regexes defined via the DSL and builds a regexp string
  class Builder
    def initialize(&block)
      @regexps = []

      instance_exec(&block) if block_given?
    end

    def word_start
      @regexps << "\\b"
    end

    def one_or_more(regexp)
      @regexps << "#{regexp}+"
    end

    def build
      Regexp.new(@regexps.join)
    end
  end
end
