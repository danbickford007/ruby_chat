class Commands

  attr_accessor :used, :clients

  def initialize msg=nil, client=nil, categories=nil, category=nil, username=nil, clients=nil
    @msg = msg
    @client = client
    @categories = categories
    @category = category
    @username = username
    @clients = clients
    @used = false
  end

  def check
    exit_now
    category
    categories
    help
    history
    password
    {categories: @categories, category: @category}
  end

  def password
    if @msg.match(/password:/)
      @used = true
      Password.set(@username, @msg.split(/password:/)[1]) 
      @client.puts "yellow:password has been set."
    end
  end

  def history
    if @msg.match(/history:/)
      @used = true
      @client.puts "Topic History:"
      p hist = @msg.split(/history:/)[1]
      url = `pwd`
      url.gsub!(/\n/, '')
      p url = "#{url}/logs/#{hist}.txt"
      f = File.open(url, "r")
      f.each_line do |line|
        @client.puts "yellow:#{line}"
      end
      f.close
    elsif @msg.match(/history/)
      @used = true
      history = History.new(@client, @msg)
      history.list
    end
  end

  def exit_now
    if @msg.match(/exit/)
      @used = true
      @client.puts "exit:"
      @clients.reject! { |key| key.to_s == @username.to_s}
    end
  end

  def category
    if @msg.match(/category:/)
      @used = true
      cat = @msg.split('category:')[1]
      cat.strip!
      if @categories.include? cat
        hash = Hash[@categories.map.with_index.to_a]
        @category = hash[cat]
        quick_print_history cat
      elsif cat.match(/\d/) and @categories[cat.to_i]
        p "HERE...."
        @category = cat.to_i
        quick_print_history @categories[cat.to_i]
      else
        @categories << cat
        hash = Hash[@categories.map.with_index.to_a]
        @category = hash[cat]
      end
    end
  end

  def quick_print_history cat
    p url = `pwd`.gsub(/\n/, '')
    url = "#{url}/logs/"
    p file = "#{url}#{cat}.txt"
    @client.puts `tail -n 15 #{file}`
  end

  def categories
    if @msg.match(/categories/)
      @used = true
      @categories.each_with_index do |cat, i|
        count = 0
        @clients.each{|k,v| count += 1 if v[1] == i} 
        @client.puts "#{i}. #{i == @category ? '*' : ''}#{cat} (#{count} active users)"
      end
    end
  end

  def help
    if @msg.match(/help/)
      @used = true
      @client.puts "Current open categories to chat in:"
      @client.puts "-----------------------------------"
      @categories.each_with_index do |cat, i|
        @client.puts "#{i}. #{cat}"
      end
      @client.puts "yellow:-----------------------------------------------------------------------------------------------"
      @client.puts "To select a category, issue command 'category:test' with 'test being the name of your category'"
      @client.puts "yellow:-----------------------------------------------------------------------------------------------"
      @client.puts "To view all the categories and your current category defined by '*', issue command 'categories'"
      @client.puts "yellow:-----------------------------------------------------------------------------------------------"
      @client.puts "To exit, issue command 'exit'"
      @client.puts "yellow:-----------------------------------------------------------------------------------------------"
      @client.puts "To keep your username, set a password by issuing 'password:1234'"
      @client.puts "yellow:-----------------------------------------------------------------------------------------------"
      @client.puts "To view all available history for different topics, issue command 'history'"
      @client.puts "yellow:-----------------------------------------------------------------------------------------------"
      @client.puts "To view history for a specific subject, issue command 'history:myCategory' with myCategory being the history to view"
    end
    category
  end

end
