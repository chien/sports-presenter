class LocaleRequest
  def initialize(app)
    @app = app
  end

  def call(env)
    region = env["HTTP_X_PLAYUP_GEOIP_REGION_CODE"] || "NA"
    region = $1 if env["QUERY_STRING"] =~ /region\=(..)/
    env["rack.region"] = region

    country = env["HTTP_X_PLAYUP_GEOIP_COUNTRY_CODE"] || "US"
    country = $1 if env["QUERY_STRING"] =~ /country\=(..)/
    env["rack.country"] = country

    old_locale = I18n.locale
    locale = nil

    lang = env["HTTP_ACCEPT_LANGUAGE"]
    lang = $1 if env["QUERY_STRING"] =~ /locale\=([a-z\-\,]+)/i

    locale = if lang
      accepted_codes = lang.split(";q").first.split(",")

      accepted_codes.detect do |code|
        !I18n.translate(:tiles, :locale => code).include?("translation missing:")
      end
    end

    locale ||= I18n.default_locale

    locale = env['rack.locale'] = I18n.locale = locale.to_s
    status, headers, body = @app.call(env)

    headers['Content-Language'] = locale
    headers['X-PlayUp-Geoip-Region-Code'] = region
    headers['X-PlayUp-Geoip-Country-Code'] = country

    I18n.locale = old_locale
    [status, headers, body]
  end
end
