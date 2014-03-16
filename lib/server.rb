#!/usr/bin/env ruby -w
require "socket"
class Server

  def initialize( port, ip )
    @server = TCPServer.open( ip, port )
    @connections = Hash.new
    @rooms = Hash.new
    @clients = Hash.new
    @connections[:server] = @server
    @connections[:rooms] = @rooms
    @connections[:clients] = @clients
    @categories = ['Ruby', 'Rails']
    run
  end
 
  def run
    loop {
      Thread.start(@server.accept) do | client |
        nick_name = client.gets.chomp.to_sym
        @connections[:clients].each do |other_name, other_client|
          if nick_name == other_name || client == other_client
            client.puts "This username already exist"
            Thread.kill self
          end
        end
        puts "#{nick_name} #{client}"
        @connections[:clients][nick_name] = client
        client.puts "Connection established, Thank you."
        client.puts "Please choose a category\n"
        @categories.each_with_index do |cat, i|
          client.puts "#{i}. #{cat}"
        end
        p "CATGEGORY...."
        category = client.gets.chomp.to_i
        p category
        @connections[:clients]['category'] = category
        client.puts "Starting chat..."
        listen_user_messages( nick_name, client, category)
      end
    }.join
  end

  def check_for_commands client, msg
    if msg.match(/exit/)
      client.puts "Exiting..."
    elsif msg.match(/category:/)
      client.puts "Changing category..."
    end

  end
 
  def listen_user_messages( username, client, category )
    loop {
      msg = client.gets.chomp
      check_for_commands client, msg
      @connections[:clients].each do |other_name, other_client|
        unless other_name == username  
          other_client.puts "#{@categories[category]}:: #{username.to_s}: #{msg}"
        end
      end
    }
  end
end
 
Server.new( 3000, "localhost" )