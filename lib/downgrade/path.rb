require 'rack'
module Downgrade
  class Path
    class << self
      attr_writer :regexps

      def regexps
        @regexps ||= []
      end

      def hit_regexp?(path)
        self.regexps.each do |regexp|
          if path =~ regexp
            return true
          end
        end

        false
      end
    end
  end
end
