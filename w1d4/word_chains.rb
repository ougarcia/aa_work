# find shorted rout from ARGV[0] to ARGV[1]
require 'Set'
require 'byebug'

class WordChainer

  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
  end


  def run(source, target)
    @current_words = [source].to_set
    @all_seen_words = { source => nil }
    while !@current_words.empty?
      new_current_words = explore_current_words
      @current_words = new_current_words
    end

    p build_path(source, target)
  end

  private

    def build_path(source, target)
      path = [target]
      current_word = target
      until current_word == nil || current_word == source
        current_word = @all_seen_words[current_word]
        path << current_word
      end
      path
    end

    def explore_current_words
      new_current_words = []
      @current_words.each do |current_word|
        adjacent_words(current_word).each do |adjacent_word|
          next if @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end
      end
      new_current_words.each do |new_current_word|
        print "#{@all_seen_words[new_current_word]}\t=>\t#{new_current_word}\n"
      end

      new_current_words
    end

    def adjacent_words(word)
      result = []
      words = @dictionary.select { |x| x.length == word.length }
      words.each do |candidate|
        result << candidate if adjacent?(word, candidate)
      end

      result
    end

    def adjacent?(original, candidate)
      return false if original.length != candidate.length
      strikes = 0
      (0...candidate.length).each do |i|
        strikes += 1  if original[i] != candidate[i]
      end

      strikes == 1 ? true : false
    end
end

if __FILE__ == $PROGRAM_NAME
  wc = WordChainer.new("dictionary.txt")
  # p wc.adjacent_words("duck")
  wc.run("duck", "ruby")
end
