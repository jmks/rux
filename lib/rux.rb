require "rux/builder"
require "rux/version"

module Rux
  def self.build(&block)
    builder = Builder.new
    builder.instance_exec(&block) if block_given?
    builder.build
  end
end
