def destiny = yield

forever_love = true
    
destiny do
  begin
    begin
      redo if forever_love
    end
  ensure
    forever_love = !forever_love
  end
end

p forever_love
