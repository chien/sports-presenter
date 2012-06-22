module SportsPresentation
  module Presentation
    module Presentable
      extend Forwardable
      module_eval %Q{
        def_delegators :@assets, :javascripts, :stylesheets
      }
    end
    
    class Asset
      
      attr_reader :target, :javascripts, :stylesheets
      
      def initialize(target, javascripts = [], stylesheets = [])
        @target = target
        @javascripts = javascripts
        @stylesheets = stylesheets
        ["reset", "base", "style"].each do |filename|
          @stylesheets << "#{SportsPresentation.presenter_base_url}/stylesheets/#{filename}.css"
        end
      end
    end
    
    module JqueryAsset
      def javascripts
        super << "https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
      end
    end
    
    module JqueryMobileAsset
      include JqueryAsset
      
      def javascripts
        super << "http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.js"
      end
      def stylesheets
        super << "http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.css"
      end 
    end
    
    module PresentationAsset

      def javascripts
        super << "#{SportsPresentation.presenter_base_url}/javascripts/#{underscore(self.target.class.name.split("::").last)}.js"
      end

      def stylesheets
        super << "#{SportsPresentation.presenter_base_url}/stylesheets/#{underscore(self.target.class.name.split("::").last)}.css"
      end

      def underscore(camel_cased_word)
         camel_cased_word.to_s.gsub(/::/, '/').
           gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
           gsub(/([a-z\d])([A-Z])/,'\1_\2').
           tr("-", "_").
           downcase
      end
    end
  end
end