def caesar_cipher(the_string, shift)
    str_arr = the_string.split('')
    new_arr = str_arr.map do |letter|
        info = {}
        if letter.ord.between?(97, 122)
            info[:low_bound] = 97
            info[:up_bound] = 122
            info[:is_alpha] = true
        elsif letter.ord.between?(65, 90)
            info[:low_bound] = 65
            info[:up_bound] = 90
            info[:is_alpha] = true
        else
            info[:is_alpha] = false
        end

        shiftedOrd = letter.ord + shift
        shifted = nil
        # if lower than bounds, wrap to start
        # if higher than bounds, wrap from end
        # if not a letter, keep the same
        if info[:is_alpha] == true && shiftedOrd < info[:low_bound]
            shifted = (info[:up_bound] - (info[:low_bound] - shiftedOrd) + 1).chr
        elsif info[:is_alpha] == true && shiftedOrd > info[:up_bound]
            shifted = (info[:low_bound] + (shiftedOrd - info[:up_bound]) - 1).chr
        elsif info[:is_alpha] == true
            shifted = shiftedOrd.chr
        else
            shifted = letter
        end
    end

    new_arr.join
end 