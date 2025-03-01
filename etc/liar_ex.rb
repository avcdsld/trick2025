liars = 0
for _ in [0]
  puts 0
  begin
    puts 1
    begin
      puts 2
      redo
    ensure
      puts 3
      liars += 1
    end
  ensure
    puts 4
    liars += 1
    break
  end
end
puts "liars: #{liars}"
