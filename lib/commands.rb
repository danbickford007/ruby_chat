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
    {categories: @categories, category: @category}
  end

  def exit_now
    if @msg.match(/exit/)
      @client.puts "Exiting..."
    end
  end

  def category
    if @msg.match(/category:/)
      cat = @msg.split('category:')[1]
      if @categories.include? cat
        p 'FOUND...........'
        hash = Hash[@categories.map.with_index.to_a]
        p @category = hash[cat]
      else
        p 'ADDING..........'
        @categories << cat
        hash = Hash[@categories.map.with_index.to_a]
        p @category = hash[cat]
      end
      @client.puts "Changing category..."
    end
  end

  def categories
    if @msg.match(/categories/)
      @categories.each_with_index do |cat, i|
        @client.puts "#{i}. #{cat}"
      end
    end
  end

  def help
    if @msg.match(/help/)
      @client.puts "Current Open Categories:"
      @categories.each_with_index do |cat, i|
        @client.puts "#{i}. #{cat}"
      end
    end
    category
  end

end
