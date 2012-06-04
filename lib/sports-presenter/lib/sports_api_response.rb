module SportsPresentation
  class SportsApiResponse < Hash

    def initialize(hash)
      self.merge!(hash)
    end

    # Returns a nested hash or array as a SportsApiResponse for type detection.
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

    # Supports dot notation navigation into nested hashes.
    def at(key_chain)
      result = key_chain.split(".").inject(self) { |result, key| result = result ? result[key] : nil }
    end

    # Returns the type of response.
    def playup_type
      if self[":type"]
        self[":type"].split("+").first
      else
        nil
      end
    end

    # Returns a list of all the types present in the ancestors.
    def ancestor_types
      self["ancestors"].collect { |hash| hash[":type"].split("+").first.split("/", 2).last }
    end

    # Check the current type and ancestor types for the provided playup type.
    def is_playup_kind?(type)
      types = ([playup_type] + ancestor_types)
      types.include?(type)
    end
  end
end