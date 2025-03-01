loop = -> {
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
                                    raise loop
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
  rescue => e
    puts "Caught error: #{e.message}"
    -> {
      -> {
        -> {
          -> {
            -> {
              -> {
                -> {
                  -> {
                    -> {
                      -> {
                        -> {
                          -> {
                            -> {
                              -> {
                                -> {
                                  -> {
                                    raise loop
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
  end
}

result = loop.call
puts "#{result.class}"
puts result.call.call.call.call.call.call.call.call.call.call.call.call.call.call.call.call
