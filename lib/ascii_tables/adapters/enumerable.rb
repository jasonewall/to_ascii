require 'to_ascii'

Enumerable.send(:include, ToAscii::ClassExtensions)
