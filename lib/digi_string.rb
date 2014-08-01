require "digi_string/version"
require "digi_string/char"

require "colcolor"

module DigiString
  class String
    attr_reader :string
    def initialize(str, space:1, **opts)
      @space = space
      @bg = opts[:bg]
      # @string holds a sequence of Char objects.
      @string = str2chars(str, opts)
    end

    def to_s
      head, *rest = @string
      joint = (" " * @space).colco(@bg, regexp:/./)
      head.zip(*rest).map { |e| e.join(joint) }.join("\n")
    end

    def +(other, **opts)
      other =
        case other
        when ::String, ::Symbol
          str2chars(other, opts)
        when DigiString::String
          other.string
        else
          raise "'other' should be a string, symbol or DigiString object."
        end
      @string + other
    end

    private
    def str2chars(str, opts)
      str.to_s.each_char.map { |chr| Char[chr.intern, opts] }
    end
  end
end
