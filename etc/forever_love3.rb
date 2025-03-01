forever_love = true
    
loop do
  begin
    begin
      redo
    ensure
    end
  ensure
    forever_love = !forever_love
    break
  end
end

p forever_love
