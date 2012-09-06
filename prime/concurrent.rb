require 'thread'

def prime n, concurrent_num=8

  prime_list = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
  pre_filter = lambda do |i| 
    not prime_list.each{|x| break if( i % x == 0) }.nil?
  end
  full_list = (101..n).to_a.select{|i| pre_filter.call(i)}

  stop_index = (n ** 0.5).floor
  last_prime = full_list.first
  
  while(last_prime < stop_index)
    done = false
    results = split_range(full_list.size,concurrent_num) do |range|
      queue = Queue.new
      list = full_list[range]
      t = Thread.new do
        while(prime_number = queue.pop)
          list.delete_if{|n| (n > prime_number) && (n % prime_number == 0) }
        end
        list
      end
      {q: queue, l: list, t: t}
    end

    last_prime = results.first[:l].reduce(0) do |sum, i|
      break i if i > stop_index
      results.each{|result| result[:q].push(i)}
      i
    end
    results.each{|result| result[:q].push(false)} # tell thread to stop the task
    prime_list = prime_list.concat(results[0][:t].value) # the list of the first task is filtered
    full_list = results[1..-1].map{|result| result[:t].value}.flatten
  end
  prime_list.concat(full_list.flatten).count
end

# 将传入的总数分解为若干个首尾相连的 range ，range 个数为 concurrent_num 
def split_range total_num, concurrent_num
  quotient = total_num / concurrent_num
  remainder = total_num % concurrent_num
  ranges = concurrent_num.times.map{|i|
    [i * quotient, (i+1) * quotient]
  }
  ranges.last[1] += remainder if remainder > 0
  ranges.map do |range| 
    yield (range[0]...range[1])
  end
end

