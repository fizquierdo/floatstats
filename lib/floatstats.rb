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
  # operations with 2 enumerable vectors
  def self.product(x,y)
    x.zip(y).map{|i,j| i*j}
  end
  def self.distance(x,y)
    x.zip(y).map{|i,j| i-j}
  end
  def self.ratio(x,y)
    x.zip(y).map{|i,j| i.to_f / j.to_f}
  end
  def self.pearson_correlation(x, y)
    xda = x.diffavg
    yda = y.diffavg
    num = self.product(xda, yda).sum
    den = Math.sqrt(xda.sum_of_squares * yda.sum_of_squares)
    num / den
  end
  def self.spearman_rank(x, y)
    n = x.size
    num = 6 * self.distance(x.rank, y.rank).sum_of_squares
    den = n * (n**2 - 1)
    1.0 - num.to_f/den.to_f 
  end
  def self.spearman_rank2(x, y)
    self.pearson_correlation(x.rank, y.rank)
  end
end
