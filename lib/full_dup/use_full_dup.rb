# coding: utf-8

# A mixin for classes where the full dup is a full dup.
module FullDup
  #The common part of the full_dup.
  def full_dup(progress={})
    progress[object_id] = result = dup
    exclude = full_dup_exclude

    if exclude.empty?
      result.full_dup_no_exclusions(progress)
    else
      result.full_dup_with_exclusions(progress, exclude)
    end

    result
  end
end
