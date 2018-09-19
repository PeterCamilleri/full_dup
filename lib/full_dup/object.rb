# coding: utf-8

# Add full_dup support to the object class.
class Object

  #By default, no instance variables are excluded.
  def full_dup_exclude
    []
  end

  #The full_dup method for most objects.
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
    instance_variables.each do |name|
      value = instance_variable_get(name)
      value = progress[value.object_id] || value.full_dup(progress)
      instance_variable_set(name, value)
    end
  end

  # Do a full_dup with exclusions
  def full_dup_with_exclusions(progress, exclude)
    instance_variables.each do |name|
      unless exclude.include?(name)
        value = instance_variable_get(name)
        value = progress[value.object_id] || value.full_dup(progress)
        instance_variable_set(name, value)
      end
    end
  end

end
