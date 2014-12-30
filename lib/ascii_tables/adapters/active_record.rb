require 'ascii_tables'

module AsciiTables::Adapters::ActiveRecordExtensions
  def to_a_for_ascii
    where(nil).to_a
  end
end

ActiveRecord::Base.send(:extend, AsciiTables::ClassExtensions)
ActiveRecord::Base.send(:extend, AsciiTables::Adapters::ActiveRecordExtensions)
