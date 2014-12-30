# AsciiTables

Adds the #to_ascii method to a number of collection type classes to print out a nicely formatted
  ASCII table of the attributes of each element.

## Installation

Add this line to your application's Gemfile:

    gem 'ascii_tables'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ascii_tables

## Usage

Require an adapter. By default the `to_ascii` method doesn't get added to anything until you require
one of the following:

    require 'ascii_tables/adapters/active_record'
    require 'ascii_tables/adapters/enumerable'
    require 'ascii_tables/adapters/array'
    require 'ascii_tables/adapters/all' # requires all of the above

Then:

    Person.where(:last_name => 'Newton').to_ascii do
      column :id, 6 # number is the column width
      column :first_name, 24
      column :last_name, 32
    end

You can also define visitor/serializer classes based on model names:

    class PersonToAscii < AsciiTables::Visitor
      column :id, 6
      column :first_name, 24
      column :last_name, 32
    end

And then `Person.where(:last_name => 'Newton').to_ascii` just works. Look, ma! No block!

Or, create visitor classes that are called whatever and pass them into `#to_ascii` yourself!

    class GarblyNamed < AsciiTables::Visitor
      column :id, 6
      column :first_name, 24
      column :last_name, 32
    end

`Person.where(:last_name => 'Newton').to_ascii(GarblyNamed)`

## Contributing

1. Fork it ( http://github.com/thejayvm/to_ascii/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
