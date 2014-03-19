class Category
  def initialize client, msg
    @client = client
    @msg = msg
  end

  def additional_categories
    history = History.new(@client, @msg)
    history.array
  end

  def self.array
    arr = []
    p url = `pwd`.gsub(/\n/, '')
    url = "#{url}/logs"
    Dir.foreach(url) do |item|
      next if item == '.' or item == '..'
      arr << item.split('.')[0]
    end
    arr
  end
end
