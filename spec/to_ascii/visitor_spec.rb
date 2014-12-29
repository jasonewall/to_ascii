require 'spec_helper'

describe ToAscii::Visitor do
  let(:visitor) { Class.new(ToAscii::Visitor) }

  def column_name_of col
    col[0]
  end

  def column_width_of col
    col[1]
  end

  subject { visitor }

  describe :id do
    it 'should, by default, add a column :id with width of 6' do
      subject.id
      expect(subject.columns.length).to eq 1
      subject.columns.first.tap do |col|
        expect(column_name_of col).to eq :id
        expect(column_width_of col).to eq 6
      end
    end

    it 'should accept a width param though' do
      subject.id(18)
      expect(column_width_of subject.columns.first).to eq 18
    end
  end

  describe :method_missing do
    it 'should generate any column def' do
      visitor.magic_potion
      expect(subject.columns.length).to eq 1
      subject.columns.first.tap do |col|
        expect(column_name_of col).to eq :magic_potion
        expect(column_width_of col).to eq 14
      end
    end

    it 'should accept a width argument' do
      subject.magic_potion(300)
      expect(column_width_of subject.columns.first).to eq(300)
    end

    it 'should raise arity errors if has too many args' do
      # this might save some people some headaches
      expect { subject.magic(30, :id) }.to raise_error(ArgumentError, 'wrong number of arguments (2 for 0..1)')
    end
  end
end
