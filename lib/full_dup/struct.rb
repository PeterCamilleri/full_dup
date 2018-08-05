# coding: utf-8

class Struct

  #The full_dup method for structs.
  def full_dup(progress={})
    progress[object_id] = result = dup
    exclude = full_dup_exclude

    if exclude.empty?
      members.each do |name|
        value = result[name]
        value = progress[value.object_id] || value.full_dup(progress)
        result[name] = value
      end
    else
      members.each do |name|
        unless exclude.include?(name)
          value = result[name]
          value = progress[value.object_id] || value.full_dup(progress)
          result[name] = value
        end
      end
    end

    result
  end

end
