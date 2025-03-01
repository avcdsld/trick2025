def forever_love?
  love = true

  loop do
    begin
      begin
        redo
      ensure
      end
    ensure
      love = !love
      break
    end
  end

  love
end

p forever_love?
