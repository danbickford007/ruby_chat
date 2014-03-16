require 'spec_helper'

describe Commands do 

  let(:commands) { Commands.new('test', {}, ['Ruby', 'Rails'], 'Rails') }

  describe '#check' do

    it 'should call exit_now' do
      commands.should_receive(:exit_now)
      commands.check
    end
    
    it 'should call category' do
      commands.should_receive(:category)
      commands.check
    end
    
    it 'should call categories' do
      commands.should_receive(:categories)
      commands.check
    end

  end

end
