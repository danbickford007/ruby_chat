#!/usr/bin/env ruby -w
require "socket"
require_relative "commands"
require_relative "logger"
require_relative "password"
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
        if nick_name.to_s.match(/session:/)
          client.puts "Welcome back #{nick_name.to_s.split(/session:/)[1]}, press enter to continue..."
          client.puts "session:#{nick_name.to_s.split(/session:/)[1]}"
          nick_name = nick_name.to_s.split(/session:/)[1]
        else
          @connections[:clients].each do |other_name, other_client|
            if nick_name == other_name || client == other_client
              client.puts "This username already exist"
              client.puts "Please enter the password to access this account:"
              pass = client.gets.chomp
              if !Password.check(nick_name.to_s, pass.to_s)
                client.puts 'disconnecting...'
                client.puts 'exit:'
              end
            end
          end
          client.puts "session:#{nick_name.to_s}"
        end
        choose_category nick_name, client
        category = client.gets.chomp.to_i
        p category
        @connections[:clients][nick_name] = [client, category]
        client.puts "Starting chat..."
        listen_user_messages( nick_name, client, category)
      end
    }.join
  end

  def choose_category nick_name, client
    puts "#{nick_name} #{client}"
    client.puts "Connection established, Thank you."
    client.puts "Please choose a category\n"
    @categories.each_with_index do |cat, i|
      client.puts "#{i}. #{cat}"
    end
  end

  def check_for_commands username, client, msg, category
    @commands = Commands.new msg, client, @categories, category, username
    result = @commands.check
    @categories = result[:categories]
    result[:category]
  end
 
  def listen_user_messages( username, client, category )
    loop {
      msg = client.gets.chomp
      category = check_for_commands username, client, msg, category
      @connections[:clients].each do |other_name, other_client|
        if category == other_client[1] 
          p "sending to other....#{username}"
          if other_name == username
            other_client[0].puts "red:#{username.to_s}: #{msg}"
          else
            other_client[0].puts "#{username.to_s}: #{msg}"
          end
        end
        if other_name == username
          Logger.log(@categories[category], "#{username}: #{msg}")
          other_client[1] = category
        end
      end
    }
  end
end
 
Server.new( 3000, "" )
