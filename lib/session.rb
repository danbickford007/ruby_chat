require_relative "password"
require_relative "user"
class Session
  @@instance = Session.new
  def self.instance
    return @@instance
  end

  def self.has_session?
    current != '' and current != nil and current != false
  end

  def self.current
    begin
      target = File.open(".session.txt", 'r')
      return target.read
      target.close
    rescue
      false
    end
  end

  def self.create name
    target = File.open(".session.txt", 'w+')
    target.write name
    target.close
  end

  def self.prompt_password(nick_name, client)
    p 'XXXXXXXXXXXXXXXXX'
    client.puts "This username already exist"
    client.puts "Please enter the password to access this account:"
    pass = client.gets.chomp
    if !Password.check(nick_name.to_s, pass.to_s)
      client.puts 'disconnecting...'
      client.puts 'exit:'
    end
  end


  private_class_method :new
end
