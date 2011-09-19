#!/usr/lib/env ruby
# format
class Float
  def r_to(x)
    num = (self * 10**x).round.to_f / 10**x
    sprintf("%.#{x}f", num)
  end
end
# statistics
# expects floating point arrays
module Enumerable
  def sum
    self.inject(0){|acc,i|acc + i}
  end
  def sum_of_squares
    self.inject(0){|acc,i| acc + i**2}
  end
  def average
    self.sum / self.length.to_f
  end
  def diffavg
    avg = self.average
    self.map{|v| v - avg}
  end
  def sample_variance
    self.diffavg.sum_of_squares / self.length.to_f
  end
  def standard_deviation
    Math.sqrt(self.sample_variance)
  end
end
