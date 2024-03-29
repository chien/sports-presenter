class CacheSettings
  def initialize app, pat
    @app = app
    @pat = pat
  end
  
  def call env
    path = env["PATH_INFO"]
    res = @app.call(env)
    @pat.each do |pattern,data|
      if path =~ pattern
        res[1]["Cache-Control"] = data[:cache_control] if data.has_key?(:cache_control)
        res[1]["Expires"] = (Time.now + data[:expires]).utc.rfc2822 if data.has_key?(:expires)
        res[1]["Vary"] = "Accept,Accept-Language,X-PlayUp-Geoip-Country-Code,X-PlayUp-Geoip-Region-Code"
        return res
      end
    end
    res
  end
end

