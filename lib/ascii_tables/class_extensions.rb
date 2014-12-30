module AsciiTables
  module ClassExtensions
    def to_ascii(visitor = nil, io = STDOUT, &block)
      begin
        visitor ||= Visitor.for_class(self) unless block_given?
      rescue NameError => e
        warn "Missing default visitor for #{self} and no overrides provided"
        raise e
      end
      visitor ||= Visitor
      visitor = visitor.new
      visitor.instance_eval(&block) if block_given?

      a = to_a_for_ascii # important to load before so activerecord logs don't get mixed into the table
      visitor.headers(io)
      a.each do |row|
        io.puts visitor.visit(row)
      end
      io.puts visitor.cell_border
      io
    end

    def to_a_for_ascii
      to_a
    end
  end
end
