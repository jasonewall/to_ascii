require 'spec_helper'

describe ToAscii::Visitor do
  let(:visitor) { Class.new(ToAscii::Visitor) }

  def column_name_of col
    col[0]
  end

  def column_width_of col
    col[1]
  end

  describe :id do
    it 'should, by default, add a column :id with width of 6' do
      visitor.id
      expect(visitor.columns.length).to eq 1
      visitor.columns.first.tap do |col|
        expect(column_name_of col).to eq :id
        expect(column_width_of col).to eq 6
      end
    end

    it 'should accept a width param though' do
      visitor.id(18)
      expect(column_width_of visitor.columns.first).to eq 18
    end
  end

  describe :method_missing do
    it 'should generate any column def' do
      visitor.magic_potion
      expect(visitor.columns.length).to eq 1
      visitor.columns.first.tap do |col|
        expect(column_name_of col).to eq :magic_potion
        expect(column_width_of col).to eq 14
      end
    end

    it 'should accept a width argument' do
      visitor.magic_potion(300)
      expect(column_width_of visitor.columns.first).to eq(300)
    end
  end
end
