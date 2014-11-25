module ToAscii::Adapters::ActiveRecordExtensions
  def to_a_for_ascii
    where(nil).to_a
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.send(:extend, ToAscii::ClassExtensions)
  ActiveRecord::Base.send(:extend, ToAscii::Adapters::ActiveRecordExtensions)
end
