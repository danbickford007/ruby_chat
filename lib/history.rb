class History

  def initialize client, msg
    @client = client
    @msg = msg
  end

  def list
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

  def array
    arr = []
    url = "#{url}/logs"
    Dir.foreach(url) do |item|
      next if item == '.' or item == '..'
      arr << item.split('.')[0]
    end
    arr
  end

end
