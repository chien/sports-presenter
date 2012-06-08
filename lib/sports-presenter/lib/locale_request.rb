class LocaleRequest
  def initialize(app)
    @app = app
  end

  def call(env)
    region = env["HTTP_X_PLAYUP_GEOIP_COUNTRY_CODE"] || "NA"
    region = $1 if env["QUERY_STRING"] =~ /region\=(..)/

    env["rack.region"] = region

    old_locale = I18n.locale
    locale = nil

    lang = env["HTTP_ACCEPT_LANGUAGE"]
    lang = $1 if env["QUERY_STRING"] =~ /locale\=(..)/

    # http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
    if lang
      lang = lang.split(",").map { |l|
        l += ';q=1.0' unless l =~ /;q=\d+\.\d+$/
        l.split(';q=')
      }.first
      locale = lang.first.split("-").first
    else
      locale = I18n.default_locale
    end

    locale = env['rack.locale'] = I18n.locale = locale.to_s
    status, headers, body = @app.call(env)

    headers['Content-Language'] = locale
    headers['X-PlayUp-Geoip-Country-Code'] = region

    I18n.locale = old_locale
    [status, headers, body]
  end
end
