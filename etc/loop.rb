loop = lambda do
  begin
    loop {
      loop {
        loop {
          loop {
            loop {
              loop {
                loop {
                  loop {
                    loop {
                      loop {
                        loop {
                          loop {
                            loop {
                              loop {
                                loop {
                                  loop {
                                    return -> { loop }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  rescue
  end
end
puts loop.to_s
