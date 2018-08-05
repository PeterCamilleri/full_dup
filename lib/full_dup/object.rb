# coding: utf-8

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
      instance_variables.each do |name|
        value = result.instance_variable_get(name)
        value = progress[value.object_id] || value.full_dup(progress)
        result.instance_variable_set(name, value)
      end
    else
      instance_variables.each do |name|
        unless exclude.include?(name)
          value = result.instance_variable_get(name)
          value = progress[value.object_id] || value.full_dup(progress)
          result.instance_variable_set(name, value)
        end
      end
    end

    result
  end

end
