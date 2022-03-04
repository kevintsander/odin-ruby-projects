def bubble_sort(numbers)
    swapped = nil
    sortednumbers = numbers

    n = 0
    # check until sorted
    until swapped == false do
        m = 0

        swapped = false
        #check until last index - iterations (n)
        while m < sortednumbers.size - 1 - n do
            if sortednumbers[m + 1] < sortednumbers[m]
                sortednumbers.insert(m, sortednumbers.delete_at(m + 1))
                swapped = true
            end
            m += 1
        end
        n += 1
    end
    sortednumbers

end