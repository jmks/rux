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
    alias_method :word_end, :word_start
    alias_method :bow, :word_start
    alias_method :eow, :word_start

    def one_or_more(regexp)
      @regexps << "#{regexp}+"
    end

    def zero_or_more(regexp)
      @regexps << "#{regexp}*"
    end

    def zero_or_one(regexp)
      @regexps << "#{regexp}?"
    end

    def literal(string)
      @regexps << Regexp.escape(string)
    end

    def group(name = nil, &block)
      captured = Builder.new(&block).build
      wrapped = name ? "(?<#{name}>#{captured.source})" : "(#{captured.source})"

      @regexps << wrapped
    end

    def letters
      "[a-zA-Z]"
    end
    alias_method :letter, :letters

    def numbers
      "[0-9]"
    end
    alias_method :number, :numbers

    def whitespace
      @regexps << "\s"
    end
    alias_method :space, :whitespace

    def build
      Regexp.new(@regexps.join)
    end
  end
end
