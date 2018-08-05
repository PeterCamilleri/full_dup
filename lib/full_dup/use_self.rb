# coding: utf-8

module FullDupSelf
  def full_dup(_progress=nil)
    self
  end
end

class Numeric
  include FullDupSelf
end

class NilClass
  include FullDupSelf
end

class TrueClass
  include FullDupSelf
end

class FalseClass
  include FullDupSelf
end

class Symbol
  include FullDupSelf
end

class Regexp
  include FullDupSelf
end

class Thread
  include FullDupSelf
end

