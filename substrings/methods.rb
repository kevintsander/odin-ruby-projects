def substrings(word_str, dictionary)
    # split the words into array
    word_arr = word_str.split(' ')

    # count dictionary words that are included in the input string
    dictionary.reduce(Hash.new(0)) do |counts, dict_word|
        #check each word in input string separately
        word_arr.each do |word|
            if (word.downcase.include?(dict_word.downcase))
                counts[dict_word] += 1
            end
        end
        counts
    end
end