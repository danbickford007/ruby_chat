class Commands

  def initialize msg, client, categories, category
    @msg = msg
    @client = client
    @categories = categories
    @category = category
  end

  def check
    exit_now
    category
    categories
    help
    history
    {categories: @categories, category: @category}
  end

  def history
    if @msg.match(/history:/)
      @client.puts "Topic History:"
      p hist = @msg.split(/history:/)[1]
      url = `pwd`
      url.gsub!(/\n/, '')
      p url = "#{url}/logs/#{hist}.txt"
      f = File.open(url, "r")
      f.each_line do |line|
        @client.puts line
      end
      f.close
    elsif @msg.match(/history/)
      @client.puts "Recent Topics:"
      p "URL"
      p url = `pwd`
      url.gsub!(/\n/, '')
      url = "#{url}/logs"
      Dir.foreach(url) do |item|
        next if item == '.' or item == '..'
        @client.puts item.split('.')[0]
      end
    end
  end

  def exit_now
    if @msg.match(/exit/)
      @client.puts "Exiting..."
    end
  end

  def category
    if @msg.match(/category:/)
      cat = @msg.split('category:')[1]
      cat.strip!
      if @categories.include? cat
        hash = Hash[@categories.map.with_index.to_a]
        @category = hash[cat]
      elsif cat.match(/\d/) and @categories[cat.to_i]
        p "HERE...."
        @category = cat.to_i
      else
        @categories << cat
        hash = Hash[@categories.map.with_index.to_a]
        @category = hash[cat]
      end
      @client.puts "Changing category..."
    end
  end

  def categories
    if @msg.match(/categories/)
      @categories.each_with_index do |cat, i|
        @client.puts "#{i}. #{i == @category ? '*' : ''}#{cat}"
      end
    end
  end

  def help
    if @msg.match(/help/)
      @client.puts "Current Open Categories:"
      @categories.each_with_index do |cat, i|
        @client.puts "#{i}. #{cat}"
      end
      @client.puts "To select a category, issue command 'category:test' with 'test being the name of your category'"
      @client.puts "To view all the categories and your current category defined by '*', issue command 'categories'"
      @client.puts "To exit, issue command 'exit'"
    end
    category
  end

end
