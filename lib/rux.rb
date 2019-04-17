require "rux/builder"
require "rux/version"

module Rux
  def self.build(&block)
    Builder.new(&block).build
  end
end
