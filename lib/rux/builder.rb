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

    def line_start
      @regexps << "^"
    end
    alias_method :bol, :line_start

    def line_end
      @regexps << "$"
    end
    alias_method :eol, :line_end

    def one_or_more(regexp = nil, &block)
      inner_regexp = block_given? ? build_nested(&block) : regexp

      @regexps << "#{inner_regexp}+"
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
      inner_regexp = build_nested(&block)

      capture_start, capture_end =
        if name
          %W[(?<#{name}> )]
        else
          %w[( )]
        end

      wrapped = [capture_start, inner_regexp, capture_end]

      @regexps << wrapped
    end

    def noncapturing_group(&block)
      inner_regexp = build_nested(&block)

      @regexps << ["(?:", inner_regexp, ")"]
    end
    alias_method :nc_group, :noncapturing_group

    def within(*literals)
      @regexps << ["[", *literals, "]"].join
    end

    def not_within(*literals)
      @regexps << ["[^", *literals, "]"].join
    end

    def one_of(*literals)
      @regexps << literals.join("|")
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

    private

    def build_nested(&block)
      Builder.new(&block).build.source
    end
  end
end
