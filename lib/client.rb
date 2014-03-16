#!/usr/bin/env ruby -w
require "socket"
require 'colorize'
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
        puts "#{msg}".blue
      }
    end
  end
 
  def send
    puts "Enter the username:".red
    @request = Thread.new do
      loop {
        msg = $stdin.gets.chomp
        @server.puts( msg )
      }
    end
  end

  def self.start
    server = TCPSocket.open( "localhost", 3000 )
    #server = TCPSocket.open( "http://54.83.36.99", 3000 )
    Client.new( server )
  end

end
 
