# coding: utf-8

require_relative '../lib/full_clone'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class HashFullCloneTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_basic_deep_cloning
    sa = "North"
    simple1 = {iva: sa, ivb: 5, ivc: nil}
    simple2 = simple1.full_clone

    assert_equal(simple1[:iva], simple2[:iva])
    assert_equal(simple1[:ivb], 5)
    assert_equal(simple1[:ivc], nil)
    refute_equal(simple1[:iva].object_id, simple2[:iva].object_id)

    sa << "West"

    assert_equal(sa, "NorthWest")
    assert_equal(simple1[:iva], "NorthWest")
    assert_equal(simple2[:iva], "North")
  end

  def test_with_exclusion
    sa = "North"
    simple1 = {iva: sa, ivb: 5, ivc: nil}
    simple1.define_singleton_method(:full_clone_exclude) {[:iva]}
    assert_equal(simple1.singleton_methods, [:full_clone_exclude])
    simple2 = simple1.full_clone
    assert_equal(simple2.singleton_methods, [:full_clone_exclude])

    assert_equal(simple1[:iva], simple2[:iva])
    assert_equal(simple1[:ivb], 5)
    assert_equal(simple1[:ivc], nil)
    assert_equal(simple1[:iva].object_id, simple2[:iva].object_id)
  end

  def test_with_direct_looping
    simple1 = {iva: 'East', ivb: 5, ivc: nil}
    simple1[:ivc] = simple1
    simple2 = simple1.full_clone

    assert_equal(simple2.object_id, simple2[:ivc].object_id)
    refute_equal(simple1.object_id, simple2[:ivc].object_id)
  end

  def test_with_direct_looping_and_exclusion
    simple1 = {iva: 'East', ivb: 5, ivc: nil}
    simple1.define_singleton_method(:full_clone_exclude) {[:ivc]}
    assert_equal(simple1.singleton_methods, [:full_clone_exclude])
    simple1[:ivc] = simple1
    simple2 = simple1.full_clone
    assert_equal(simple2.singleton_methods, [:full_clone_exclude])

    refute_equal(simple2.object_id, simple2[:ivc].object_id)
    assert_equal(simple1.object_id, simple2[:ivc].object_id)
  end

  def test_with_indirect_looping
    simple1 = {iva: 'East', ivb: 5, ivc: nil}
    simple3 = {iva: 'West', ivb: 6, ivc: simple1}
    simple1[:ivc] = simple3
    simple2 = simple1.full_clone

    assert_equal(simple2.object_id, simple2[:ivc][:ivc].object_id)
  end

end