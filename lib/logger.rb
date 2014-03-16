class Logger
  @@instance = Logger.new
  def self.instance
    return @@instance
  end

  def self.log(category, msg)
    target = File.open("logs/#{category}.txt", 'a')
    target.write "______________________________\n"
    target.write "#{msg}\n"
    target.close
  end
  private_class_method :new
end
