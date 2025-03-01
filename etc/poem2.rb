def 詩(深さ = 0)
  print " " * 深さ, %w[霞 遠音 余白 静寂][深さ % 4], "\n"
  loop { 詩(深さ + 1) if rand < 0.5; break }
end

詩
