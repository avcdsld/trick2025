def destiny = yield

def forever_love?
  love = true
  destiny do
    begin
      begin
        redo if love
      end
    ensure
      love = !love
    end
  end
  love
end

p forever_love?
