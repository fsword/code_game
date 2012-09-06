# 命令行：jruby --server -Xcompile.invokedynamic=true -J-Djruby.thread.pooling=true -J-Xmn768m -J-Xms1280m -J-Xmx1280m -J-Xss256k -J-XX:PermSize=64m -J-XX:MaxPermSize=64m -J-XX: UseParNewGC -J-XX: UseConcMarkSweepGC -J-Djruby.compile.fastest=true -J-Djruby.compile.fastops=true benchmark.rb

def prime max_number
  nums = Array.new(max_number, 1)       
  sqrt_num = Math.sqrt(max_number).to_i
  (4...max_number).step(2) { |n| nums[n] = 0 }
  (3...sqrt_num).step(2) { |n| (n * 2...max_number).step(n) { |m| nums[m] = 0 } if (nums[n] == 1) }
  return nums.count(1) - 2
end
