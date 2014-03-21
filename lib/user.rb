require 'json'
class User

  def initialize

  end

  def create(username)
    users = find
    users[username.to_s] = username
    file = File.open('.users.txt', 'w+b')
    file.write(users.to_json)
    file.close
  end

  def find
    users = {}
    File.open('.users.txt', 'rb') do |file|
      contents = file.read
      if contents != ""
        users = JSON.parse(contents)
      end
    end
    users
  end

  def check(name)
    users = find
    users[name] == name
  end

end
