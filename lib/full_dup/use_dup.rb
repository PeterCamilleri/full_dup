# coding: utf-8

module FullDupDup
  def full_dup(_progress=nil)
    dup
  end
end

class String
  include FullDupDup
end

class Enumerator
  include FullDupDup
end

class MatchData
  include FullDupDup
end
