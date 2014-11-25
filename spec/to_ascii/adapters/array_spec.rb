require 'spec_helper'
require 'to_ascii/adapters/array'

describe Array do
  Person = Struct.new(:first_name, :last_name)

  let(:people) do
    [Person.new('Isaac', 'Newton'), Person.new('Albert', 'Einstein')]
  end
  let(:io) { StringIO.new }

  it 'should add to_ascii to an array' do
    people.to_ascii(nil, io) do
      column :first_name, 16
      column :last_name, 16
    end

    %w(Isaac Newton Albert Einstein first_name last_name).each do |word|
      expect(io.string).to match(/#{word}/)
    end
  end
end
