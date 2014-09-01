module CustomExceptions
  module LocalesException 
    class UnknownLocale < StandardError
      def message
        "locale not found"
      end
    end
  end
end


