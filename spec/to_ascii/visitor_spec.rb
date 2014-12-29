require 'spec_helper'

describe ToAscii::Visitor do
  let(:visitor) { Class.new(ToAscii::Visitor) }

  def column_name_of col
    col[0]
  end

  def column_width_of col
    col[1]
  end

  shared_examples_for 'a column definer' do
    describe :id do
      it 'should, by default, add a column :id with width of 6' do
        result = subject.id
        expect(column_name_of result).to eq :id
        expect(column_width_of result).to eq 6
      end

      it 'should accept a width param though' do
        result = subject.id(18)
        expect(column_width_of result).to eq 18
      end
    end

    describe :method_missing do
      it 'should generate any column def' do
        result = subject.magic_potion
        expect(column_name_of result).to eq :magic_potion
        expect(column_width_of result).to eq 14
      end

      it 'should accept a width argument' do
        result = subject.magic_potion(300)
        expect(column_width_of result).to eq(300)
      end

      it 'should raise arity errors if has too many args' do
        # this might save some people some headaches
        expect { subject.magic(30, :id) }.to raise_error(ArgumentError, 'wrong number of arguments (2 for 0..1)')
      end
    end
  end

  subject { visitor }

  it_should_behave_like 'a column definer'

  context :instance do
    subject { visitor.new }

    it_should_behave_like 'a column definer'
  end
end
