# coding: utf-8

require_relative 'full_dup/version'
require_relative 'full_dup/object'
require_relative 'full_dup/array'
require_relative 'full_dup/hash'
require_relative 'full_dup/struct'

module FullDup
  def full_dup(_progress={})
    self
  end
end

class Numeric
  include FullDup
end

class NilClass
  include FullDup
end

class TrueClass
  include FullDup
end

class FalseClass
  include FullDup
end

class Symbol
  include FullDup
end

class Regexp
  include FullDup
end
