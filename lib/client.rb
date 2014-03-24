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
        puts msg = @server.gets.chomp
      }
    end
  end
 
  def send
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
 
