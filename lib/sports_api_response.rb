class SportsApiResponse < Hash

  def initialize(hash)
    self.merge!(hash)
  end

  def [](value)
    data = super
    if data.is_a?(Hash)
      SportsApiResponse.new(data)
    elsif data.is_a?(Array)
      data.collect { |entry| SportsApiResponse.new(entry) }
    else
      data
    end
  end

  def at(key_chain)
    result = key_chain.split(".").inject(self) { |result, key| result = result ? result[key] : nil }
    # SportsApiResponse.new(result) if result
  end

  # Returns the type of response.
  def playup_type
    if self[":type"]
      self[":type"].split("+").first
    else
      nil
    end
  end

  def ancestor_types
    self["ancestors"].collect { |hash| hash[":type"].split("+").first }
  end

  def is_playup_kind?(type)
    types = ([playup_type] + ancestor_types)
    types.include?(type)
  end
end