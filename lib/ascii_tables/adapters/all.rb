%w(active_record array enumerable).each do |f|
  require "to_ascii/adapters/#{f}"
end
