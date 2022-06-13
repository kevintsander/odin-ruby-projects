def merge_sort(arr)
  size = arr.size
  return arr.dup if size < 2

  # size + 1 trick to round up odd numbered arrays
  split_index = ((size + 1) / 2) - 1

  # split the array in half (first larger for odd sized arrays)
  left = arr[0..split_index]
  right = arr[split_index + 1..-1]

  # recursively sort the arrays
  left_sorted = merge_sort(left)
  right_sorted = merge_sort(right)

  # merge the two halves
  merged = []
  while left_sorted.any? || right_sorted.any?
    merged << if left_sorted.none?
                right_sorted.shift
              elsif right_sorted.none?
                left_sorted.shift
              else
                left_sorted.first < right_sorted.first ? left_sorted.shift : right_sorted.shift
              end
  end

  merged
end

p merge_sort([4, 5, 2, 8, 3, 9, 1, 62, 18, 23, 12, 16, 45])