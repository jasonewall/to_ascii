require 'spec_helper'

describe 'AsciiTables::Adapters::ActiveRecord' do
  module ActiveRecord
    class Base; end
  end

  require 'ascii_tables/adapters/active_record'

end
