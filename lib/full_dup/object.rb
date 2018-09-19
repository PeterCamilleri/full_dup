# coding: utf-8

# Add full_dup support to the object class.
class Object
  include FullDup

  #By default, no instance variables are excluded.
  def full_dup_exclude
    []
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
