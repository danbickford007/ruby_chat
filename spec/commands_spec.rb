require 'spec_helper'

describe Commands do 

  let(:commands) { Commands.new('test', {}, ['Ruby', 'Rails'], 'Rails') }

  describe '#check' do

    it 'should call exit_now' do
      commands.should_receive(:exit_now)
      commands.check
    end

  end

end
