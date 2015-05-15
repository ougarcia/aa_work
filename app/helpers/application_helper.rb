module ApplicationHelper

  def ugly_lyrics(lyrics)
    lines = lyrics.split("\n")
    result = []
    lines.each do |line|
      if line == ""
        result << line
      else
        result << line.split("").unshift("♫ ").join("")
      end
    end
    result.join("\n")
  end

end
