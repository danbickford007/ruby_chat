require 'json'
class Password
  
  @@instance = Password.new
  def self.instance
    return @@instance
  end

  def self.set(name, password)
    passwords = find
    passwords[name] = password
    file = File.open('.passwords.txt', 'w+b')
    file.write(passwords.to_json)
    file.close
  end

  def self.check(name, password)
    passwords = find
    passwords[name] == password 
  end

  def self.find
    passwords = {}
    File.open('.passwords.txt', 'rb') do |file|
      contents = file.read
      if contents != ""
        passwords = JSON.parse(contents)
      end
    end
    passwords
  end
  
  private_class_method :new
end
