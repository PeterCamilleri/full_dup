# coding: utf-8

# A mixin for classes where the dup is the object itself.
module FullDupSelf
  def full_dup(_progress=nil)
    self
  end
end

# Numerics answer self.
class Numeric
  include FullDupSelf
end

# NilClass objects (nil) answer self.
class NilClass
  include FullDupSelf
end

# TrueClass objects (true) answer self.
class TrueClass
  include FullDupSelf
end

# FalseClass objects (false) answer self.
class FalseClass
  include FullDupSelf
end

# Symbols answer self.
class Symbol
  include FullDupSelf
end

# Regular expressions answer self.
class Regexp
  include FullDupSelf
end

# Threads answer self.
class Thread
  include FullDupSelf
end

