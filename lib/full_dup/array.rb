# coding: utf-8

# Add full_dup support to the array class.
class Array
  include FullDup

  # Do a full_dup with no exclusions
  def full_dup_no_exclusions(progress)
    each_index do |name|
      value = self[name]
      value = progress[value.object_id] || value.full_dup(progress)
      self[name] = value
    end
  end

  # Do a full_dup with exclusions
  def full_dup_with_exclusions(progress, exclude)
    each_index do |name|
      unless exclude.include?(name)
        value = self[name]
        value = progress[value.object_id] || value.full_dup(progress)
        self[name] = value
      end
    end
  end

end
