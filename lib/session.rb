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
      target = File.open("session.txt", 'r')
      return target.read
      target.close
    rescue
      false
    end
  end

  def self.create name
    target = File.open("session.txt", 'w+')
    target.write name
    target.close
  end

  private_class_method :new
end
