def fibonacci(n)
  arr = []
  num1 = 0
  num2 = 1

  n.times do |index|
    arr << num1
    sum = num1 + num2
    num1 = num2
    num2 = sum
  end
  arr
end

def fibonacci_recursive(n, result = [])
  return [0] if n <= 1
  return [0, 1] if n == 2

  arr = fibonacci_recursive(n - 1) # get the preceding array of values
  arr << arr[-2] + arr[-1] # add the last two to get the next item
end