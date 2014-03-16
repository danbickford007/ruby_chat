require 'spec_helper'

describe Commands do 

  let(:commands) { Commands.new('test', {}, ['Ruby', 'Rails'], 'Rails') }

  describe '#check' do

    it 'should call exit_now' do
      commands.should_receive(:exit_now)
      commands.check
    end
    
    it 'should call category' do
      commands.should_receive(:category).exactly(2).times
      commands.check
    end
    
    it 'should call categories' do
      commands.should_receive(:categories)
      commands.check
    end
    
    it 'should call help' do
      commands.should_receive(:help)
      commands.check
    end

    it 'should call history' do
      commands.should_receive(:history)
      commands.check
    end

  end

  describe '#history' do
    before(:each) do
      #server = double('server')
      server = stub_const("ClassName", double("server"))
      @sock = TCPSocket.stub(:new).and_return(server)    
      server.stub(:puts)
      @sock.stub(:puts)
    end
    let(:commands) { Commands.new('history:Ruby', @sock, ['Ruby', 'Rails'], 'Rails') }

    it 'should open ruby file' do
      file = mock('file')
      File.should_receive(:open).with("Ruby.txt", "w").and_yield(file)
      commands.history
    end

  end

end
