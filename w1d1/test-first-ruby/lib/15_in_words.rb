class Fixnum
  @@small_words = {
    "0" => '',
    "1" => 'one',
    "2" => 'two',
    "3" => 'three',
    "4" => 'four',
    "5"=> 'five',
    "6" => 'six',
    "7" => 'seven',
    "8" => 'eight',
    "9" => 'nine',
    "10" => 'ten',
    "11" => 'eleven',
    "12" => 'twelve',
    "13" => 'thirteen',
    "14" => 'fourteen',
    "15" => 'fifteen',
    "16" => 'sixteen',
    "17" => 'seventeen',
    "18" => 'eighteen',
    "19" => 'nineteen'
  }
  @@tens = {
    "2" => 'twenty',
    "3" => 'thirty',
    "4" => 'forty',
    "5" => 'fifty',
    "6" => 'sixty',
    "7" => 'seventy',
    "8" => 'eighty',
    "9" => 'ninety',
  }
  @@orders = {
    0 => '',
    1  => 'thousand',
    2  => 'million',
    3 => 'billion',
    4 => 'trillion'
  }

  def in_words
    num_str = self.to_s
    case self
    when 0
      "zero"
    when 1..19
      small_words(num_str)
    when 20..99
      tens(num_str)
    when 100..999
      hundreds(num_str)
    else
      big_words(num_str)
    end
  end


  private
    def oom(digits)
      (digits.length-1) / 3
    end

    def small_words(num_str)
      @@small_words[num_str]
    end

    def tens(num_str)
      if num_str.to_i < 20
        small_words(num_str)
      else
        result = []
        arr = num_str.split('')
        result << @@tens[arr[0]]
        result << small_words(arr[1])
        result.join(' ').strip
      end
    end

    def hundreds(num_str)
      if num_str.to_i < 100
        tens(num_str)
      else
        result = []
        arr = num_str.split('')
        result << small_words(arr[0])
        result << 'hundred'
        result << tens(arr[1..2].join(''))
        result.join(' ').strip
      end
    end

    def big_words(num_str)
      result = []
      count = oom(num_str)
      arr = num_str.split('')
      remainder = (num_str.to_i / (1000 ** count)).to_s.length
      these_hundreds = arr.shift(remainder)

      loop do
        these_hundreds = these_hundreds.join("").to_i.to_s
        unless these_hundreds == "0"
          result << hundreds(these_hundreds)
          result << @@orders[count]
        end
        these_hundreds = arr.shift(3)
        count -= 1
        break if count < 0
      end
      result.join(" ").strip


    end
end
