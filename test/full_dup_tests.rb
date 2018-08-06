# coding: utf-8

require_relative '../lib/full_dup'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class FullDupTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_for_safe_value_cloning
    assert_equal((6).full_dup, 6)
    assert_equal((6).full_dup.object_id, (6).object_id)

    assert_equal((:foo).full_dup, :foo)
    assert_equal((:foo).full_dup.object_id, (:foo).object_id)

    assert_equal((true).full_dup, true)
    assert_equal((true).full_dup.object_id, (true).object_id)

    assert_equal((false).full_dup, false)
    assert_equal((false).full_dup.object_id, (false).object_id)

    assert_nil((nil).full_dup)
    assert_equal((nil).full_dup.object_id, (nil).object_id)

    rex = /ABC/
    assert_equal(rex.full_dup, rex)
    assert_equal(rex.full_dup.object_id, rex.object_id)
  end

end
