liar = false

for _ in [0]
  puts 0
  begin
    puts 1
    begin
      # loop {
      #   loop {
      #     loop {
      #       loop {
      #         loop {
      #           loop {
      #             loop {
      #               loop {
      #                 loop {
      #                   loop {
      #                     loop {
      #                       loop {
      #                         loop {
      #                           loop {
      #                             loop {
      #                               loop {
                                      puts 2
                                      next
                                      raise "liar"
      #                               }
      #                             }
      #                           }
      #                         }
      #                       }
      #                     }
      #                   }
      #                 }
      #               }
      #             }
      #           }
      #         }
      #       }
      #     }
      #   }
      # }
    rescue
    ensure
      puts 3
    end
  ensure
    liar = !liar
    puts 4
    break
  end
end

puts liar
