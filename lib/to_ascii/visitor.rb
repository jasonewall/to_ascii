module ToAscii
  class Visitor
    class << self
      def for_class(clazz)
        "#{clazz.name}ToAscii".constantize
      end

      def column(name, width)
        columns << [name, width]
      end

      def columns
        @columns ||= []
      end

      def id(width = 6)
        column :id, width
      end

      def method_missing(method, *args, &block)
        width = args.length == 1 ? args[0] : method.to_s.length + 2
        column method, width
      end
    end

    attr_reader :columns

    def initialize
      @columns = self.class.columns.dup
    end

    def column(name, width)
      columns << [name, width]
    end

    def cell_border
      @cell_border ||= "|#{columns.map { |c| '-' * c[1] }.join('|')}|"
    end

    def headers(io)
      io.puts cell_border
      io.puts "|#{columns.map { |c| c[0].to_s.center(c[1]) }.join('|')}|"
      io.puts cell_border
    end

    def visit(o)
      "|#{columns.map { |c| o.send(c[0]).to_s.center(c[1]) }.join('|')}|"
    end
  end
end
