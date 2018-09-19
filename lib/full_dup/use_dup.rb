# coding: utf-8

# The mixin for classes where dup is just simple dup.
module FullDupDup
  def full_dup(_progress=nil)
    dup
  end
end

# Strings answer dup.
class String
  include FullDupDup
end

# Enumerators answer dup.
class Enumerator
  include FullDupDup
end

# MatchData answer dup.
class MatchData
  include FullDupDup
end
