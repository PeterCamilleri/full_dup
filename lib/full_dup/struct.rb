class Struct

  #The full_clone method for structs.
  def full_clone(progress={})
    progress[object_id] = result = clone
    exclude = full_clone_exclude

    members.each do |name|

      unless exclude.include?(name)
        value = result[name]
        value = progress[value.object_id] || value.full_clone(progress)
        result[name] = value
      end

    end

    result
  end

end
