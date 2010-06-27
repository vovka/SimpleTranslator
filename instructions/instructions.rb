Given /^the quick brown fox jumps over the lazy dog ([0-9]+) time(s?)$/ do |times, plural|
  times = times.to_i
  puts "\e[1;34mThere is typo in instruction - you should use \'time\' word instead of \'times\':)\e[0m" if 's' == plural and 1 == times 
  puts "\e[1;34mThere is typo in instruction - you should use \'times\' word instead of \'time\':)\e[0m" if 's' != plural and 1 != times 
  times.times { p "The quick brown fox jumps over the lazy dog" }
end

Given /^the lazy dog waking up$/ do
  p "The lazy dog waking up: "
end

Given /^it says \"(.*)\"$/ do |phrase|
  p "\"#{phrase}\", -- it says."
end

When /^it get sight of the fox$/ do
  p "WARNING: The dog get sight of the fox!"
end

#Given /^that's all folks$/ do
#  p "The end."
#end
