chan = Channel(String).new
num = 500000
times = [] of Time::Span
10.times do
  t1 = Time.utc
  num.times do |i|
    spawn do
      chan.send "fiber #{i}: Fibers are neat!"
    end
    chan.receive
  end
  t2 = Time.utc
  time = t2 - t1
  times.push(time)
end

average = times.reduce(Time::Span.new(nanoseconds: 0)) { |acc, i| acc + i } / times.size
puts average
