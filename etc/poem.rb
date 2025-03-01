詩 = ->(言葉) {
  sleep 0.01
  puts 言葉; 詩.call(言葉.next)
}

詩.call("あ")
