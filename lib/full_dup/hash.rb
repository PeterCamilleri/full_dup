# coding: utf-8

class Hash

  #The full_dup method for hashes.
  def full_dup(progress={})
    progress[object_id] = result = dup
    exclude = full_dup_exclude

    if exclude.empty?
      each_key do |name|
        value = result[name]
        value = progress[value.object_id] || value.full_dup(progress)
        result[name] = value
      end
    else
      each_key do |name|
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
