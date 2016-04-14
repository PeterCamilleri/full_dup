class Object

  #By default, no instance variables are excluded.
  def full_clone_exclude
    []
  end

  #The full_clone method for most objects.
  def full_clone(progress={})
    progress[object_id] = result = clone
    exclude = full_clone_exclude

    instance_variables.each do |name|

      unless exclude.include?(name)
        value = result.instance_variable_get(name)
        value = progress[value.object_id] || value.full_clone(progress)
        result.instance_variable_set(name, value)
      end

    end

    result
  end

end
