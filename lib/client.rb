#!/usr/bin/env ruby -w
require "socket"
require 'colorize'
require 'session'
class Client

  @category = nil

  def initialize( server )
    @server = server
    @request = nil
    @response = nil
    listen
    send
    @request.join
    @response.join
  end
 
  def listen
    @response = Thread.new do
      loop {
        msg = @server.gets.chomp
        if msg.match(/session:/)
          Session.create(msg.split(/session:/)[1]) 
        else
          puts "#{msg}".blue
        end
      }
    end
  end
 
  def send
    if Session.current
      puts "Logging in #{Session.current}"
      @server.puts("session:#{Session.current}")
    else
      puts "Enter the username:".red
    end
    @request = Thread.new do
      loop {
        msg = $stdin.gets.chomp
        @server.puts( msg )
      }
    end
  end

  def self.start
    server = TCPSocket.open( "localhost", 3000 )
    #server = TCPSocket.open( "54.83.36.99", 3000 )
    Client.new( server )
  end

end
 
