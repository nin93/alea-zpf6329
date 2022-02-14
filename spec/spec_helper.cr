require "spec"
require "../src/alea-zpf6329"

SpecNdata = 5_000_000

def stdev(ary, mean, n)
  ans = 0.0
  ary.each do |e|
    ans += (e - mean) ** 2
  end
  Math.sqrt(ans / (n - 1))
end
