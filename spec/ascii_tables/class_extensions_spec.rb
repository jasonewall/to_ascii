require 'spec_helper'

describe AsciiTables::ClassExtensions do
  let(:io) { StringIO.new }

  class TestClass
    extend AsciiTables::ClassExtensions

    def self.to_a
      []
    end
  end

  class ClassWithNoDefaultVisitor
    extend AsciiTables::ClassExtensions

    class << self
      attr_reader :warned
      def warn(message)
        @warned = true
      end

      def to_a
        []
      end
    end
  end

  class TestClassToAscii < AsciiTables::Visitor
    column :to_ascii_visitor, 24
  end

  class CustomVisitor < AsciiTables::Visitor
    column :name, 32
  end

  describe '#to_ascii' do
    it 'should work with nil visitor param' do
      TestClass.to_ascii(nil, io)
      expect(io.string).to match(/to_ascii_visitor/)
    end

    it 'should accept a block' do
      ClassWithNoDefaultVisitor.to_ascii(nil, io) do
        columns id(10)
      end
      expect(io.string).to match(/id/)
      expect(io.string).to_not match(/to_ascii_visitor/)
    end

    it 'should accept a class' do
      ClassWithNoDefaultVisitor.to_ascii(CustomVisitor, io)
      expect(io.string).to match(/name/)
    end

    it 'should accept a combo' do
      ClassWithNoDefaultVisitor.to_ascii(CustomVisitor, io) do
        column :id, 10
      end
      expect(io.string).to match(/id/)
      expect(io.string).to match(/name/)
    end

    it 'can take the default visitor' do
      TestClass.to_ascii(TestClassToAscii, io) do
        column :id, 10
      end
      expect(io.string).to match(/id/)
      expect(io.string).to match(/to_ascii_visitor/)
    end

    it 'should raise an error when no default and nothing provided' do
      expect { ClassWithNoDefaultVisitor.to_ascii }.to raise_error(NameError)
      expect(ClassWithNoDefaultVisitor.warned).to be
    end
  end
end
