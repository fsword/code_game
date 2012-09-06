def prime n
  list = (2..n).to_a
  (2...(n ** (0.5)).floor).each do |i|
     list.delete_if{|e| e > i && e % i == 0}
  end
  list.size
end
