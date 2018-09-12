# -*- encoding : utf-8 -*-
module ToolsLibrary

	def data_filter(hash_objects, field_name, value)
	  hash_array = Array.new
	  hash_objects.each do |hash_object|
	    hash_array << hash_object if hash_object[field_name.to_sym] == value
	  end

	  return hash_array
	end
end



