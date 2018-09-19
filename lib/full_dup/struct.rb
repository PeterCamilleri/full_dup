# coding: utf-8

# Add full_dup support to the struct class.
class Struct

  #The full_dup method for structs.
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

  # Do a full_dup with no exclusions
  def full_dup_no_exclusions(progress)
    members.each do |name|
      value = self[name]
      value = progress[value.object_id] || value.full_dup(progress)
      self[name] = value
    end
  end

  # Do a full_dup with exclusions
  def full_dup_with_exclusions(progress, exclude)
    members.each do |name|
      unless exclude.include?(name)
        value = self[name]
        value = progress[value.object_id] || value.full_dup(progress)
        self[name] = value
      end
    end
  end

end
