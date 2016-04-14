# coding: utf-8

class Array

  #The full_dup method for arrays.
  def full_dup(progress={})
    progress[object_id] = result = dup
    exclude = full_dup_exclude

    each_index do |name|

      unless exclude.include?(name)
        value = result[name]
        value = progress[value.object_id] || value.full_dup(progress)
        result[name] = value
      end

    end

    result
  end

end
