class SportsApiResponse < Hash

  def initialize(hash)
    self.merge(hash)
  end

  # Returns the type of response.
  def playup_type
    self[":type"].split("+").first
  end

  def ancestor_types
    self["ancestors"].collect { |hash| hash[":type"].split("+").first }
  end

  def is_playup_kind?(type)
    types = ([playup_type] + ancestor_types)
    types.include?(type)
  end
end