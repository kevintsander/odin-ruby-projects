def substrings(word_str, dictionary)
    word_arr = word_str.split(' ')
    dictionary.reduce(Hash.new(0)) do |counts, dict_word|
        word_arr.each do |word|
            if (word.downcase.include?(dict_word.downcase))
                counts[dict_word] += 1
            end
        end
        counts
    end
end