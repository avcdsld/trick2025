# 奇妙な詩解析器 - どんな詩でも不思議に解析します
# 詩のテキストを与えると独自の方法で新しい解釈を生成します

class PoemOracle
  attr_reader :poem, :lines, :words, :characters
  
  def initialize(poem_text)
    @poem = poem_text.strip
    @lines = @poem.split("\n").reject(&:empty?)
    @words = @lines.join(" ").gsub(/[[:punct:]]/, "").split
    @characters = @words.join.chars
    @magical_number = (@characters.length * Math.sin(@lines.length)).abs.to_i
    
    # 詩の「気分」を数値化（完全に恣意的）
    @mood_map = {
      'あ' => 1, 'い' => 2, 'う' => 3, 'え' => 4, 'お' => 5,
      'か' => 6, 'き' => 7, 'く' => 8, 'け' => 9, 'こ' => 10,
      'さ' => -1, 'し' => -2, 'す' => -3, 'せ' => -4, 'そ' => -5,
      'た' => 2, 'ち' => 3, 'つ' => 4, 'て' => 5, 'と' => 6,
      'な' => -2, 'に' => -3, 'ぬ' => -4, 'ね' => -5, 'の' => -6,
      'は' => 3, 'ひ' => 4, 'ふ' => 5, 'へ' => 6, 'ほ' => 7,
      'ま' => -3, 'み' => -4, 'む' => -5, 'め' => -6, 'も' => -7,
      'や' => 4, 'ゆ' => 5, 'よ' => 6,
      'ら' => -4, 'り' => -5, 'る' => -6, 'れ' => -7, 'ろ' => -8,
      'わ' => 5, 'を' => 6, 'ん' => 7
    }
  end
  
  # 詩の「気分」を計算
  def calculate_mood
    mood_value = @characters.sum { |char| @mood_map[char] || 0 }
    mood_normalized = mood_value.to_f / @characters.length
    
    case mood_normalized
    when -Float::INFINITY..-0.5 then "深い悲しみ"
    when -0.5..-0.1 then "静かな憂鬱"
    when -0.1..0.1 then "中立的"
    when 0.1..0.5 then "穏やかな喜び"
    when 0.5..Float::INFINITY then "強い興奮"
    end
  end
  
  # 詩から新しい詩を生成
  def generate_new_poem
    # 詩の行をシャッフルして新しい順序で並べる
    shuffled_lines = @lines.shuffle
    
    # 各行の偶数番目の単語を反転
    transformed_lines = shuffled_lines.map do |line|
      words = line.split
      words.each_with_index.map do |word, i|
        i.even? ? word : word.reverse
      end.join(" ")
    end
    
    transformed_lines.join("\n")
  end
  
  # 詩の「色」を計算
  def poem_color
    hue = (@characters.sum { |c| c.ord } % 360)
    saturation = [(@lines.length % 100) / 100.0, 1.0].min
    value = [(@words.length % 100) / 100.0, 1.0].min
    
    [hue, saturation, value]
  end
  
  # HSVからRGBに変換（シンプルな実装）
  def hsv_to_rgb(h, s, v)
    h_i = (h/60).to_i % 6
    f = h/60.0 - h_i
    p = v * (1 - s)
    q = v * (1 - f * s)
    t = v * (1 - (1 - f) * s)
    
    r, g, b = case h_i
              when 0 then [v, t, p]
              when 1 then [q, v, p]
              when 2 then [p, v, t]
              when 3 then [p, q, v]
              when 4 then [t, p, v]
              when 5 then [v, p, q]
              end
    
    [(r*255).to_i, (g*255).to_i, (b*255).to_i]
  end
  
  # 詩の「音色」を計算
  def poem_sound
    # 詩のテキストから「音」を抽出
    vowels = @characters.select { |c| "あいうえお".include?(c) }.count
    consonants = @characters.count - vowels
    
    ratio = vowels.to_f / [@characters.count, 1].max
    
    if ratio > 0.7
      "流れるような、水のような音色"
    elsif ratio > 0.5
      "風のような、波打つ音色"
    elsif ratio > 0.3
      "木々のざわめきのような音色"
    else
      "石や金属のような、硬質な音色"
    end
  end
  
  # 詩の「隠されたメッセージ」を抽出
  def hidden_message
    # 各行の最初の文字を取り出して結合
    first_chars = @lines.map { |line| line[0] }.join
    
    # 各行の最後の文字を取り出して結合
    last_chars = @lines.map { |line| line[-1] }.join
    
    # 行数に応じて異なる抽出方法
    if @lines.length < 5
      "#{first_chars}...#{last_chars}"
    else
      middle_line = @lines[@lines.length / 2]
      middle_chars = middle_line.chars.select.with_index { |_, i| i.even? }.join
      "#{first_chars}...#{middle_chars}...#{last_chars}"
    end
  end
  
  # 詩の「数学的特徴」を分析
  def mathematical_properties
    word_lengths = @words.map(&:length)
    avg_word_length = word_lengths.sum.to_f / word_lengths.size
    max_word_length = word_lengths.max
    min_word_length = word_lengths.min
    
    line_lengths = @lines.map(&:length)
    avg_line_length = line_lengths.sum.to_f / line_lengths.size
    
    # フィボナッチ数列との関連性を調べる
    fibonacci = [1, 1]
    18.times { fibonacci << fibonacci[-1] + fibonacci[-2] }
    fibonacci_ratio = word_lengths.count { |l| fibonacci.include?(l) }.to_f / word_lengths.size
    
    {
      average_word_length: avg_word_length.round(2),
      max_word_length: max_word_length,
      min_word_length: min_word_length,
      average_line_length: avg_line_length.round(2),
      fibonacci_pattern_ratio: fibonacci_ratio.round(2)
    }
  end
  
  # 詩のカオス度を計算
  def chaos_index
    # 単語の長さの標準偏差
    word_lengths = @words.map(&:length)
    mean = word_lengths.sum.to_f / word_lengths.size
    variance = word_lengths.sum { |l| (l - mean) ** 2 } / word_lengths.size
    std_dev = Math.sqrt(variance)
    
    # 行の長さのばらつき
    line_lengths = @lines.map(&:length)
    line_length_ratio = line_lengths.max.to_f / [line_lengths.min, 1].max
    
    # 特殊文字の割合
    special_char_ratio = @characters.count { |c| c =~ /[!?、。：；「」『』（）・]/ }.to_f / @characters.size
    
    chaos_value = (std_dev * 0.5 + line_length_ratio * 0.3 + special_char_ratio * 10)
    
    case chaos_value
    when 0..1 then "極めて秩序的"
    when 1..2 then "整然とした"
    when 2..3 then "バランスの取れた"
    when 3..5 then "複雑性を持つ"
    when 5..10 then "不規則な"
    else "カオス的"
    end
  end
  
  # 詩の解釈を実行
  def interpret
    h, s, v = poem_color
    r, g, b = hsv_to_rgb(h, s, v)
    color_hex = "#%02x%02x%02x" % [r, g, b]
    
    math = mathematical_properties
    
    puts "===== 不思議な詩解析結果 ====="
    puts "詩の行数: #{@lines.length}"
    puts "詩の単語数: #{@words.length}"
    puts "詩の文字数: #{@characters.length}"
    puts "詩の魔法数: #{@magical_number}"
    puts
    puts "詩の気分: #{calculate_mood}"
    puts "詩の色: #{color_hex} (色相: #{h.round}°, 彩度: #{(s*100).round}%, 明度: #{(v*100).round}%)"
    puts "詩の音色: #{poem_sound}"
    puts "詩のカオス度: #{chaos_index}"
    puts
    puts "数学的特徴:"
    puts "  - 平均単語長: #{math[:average_word_length]}"
    puts "  - 最長単語長: #{math[:max_word_length]}"
    puts "  - 最短単語長: #{math[:min_word_length]}"
    puts "  - 平均行長: #{math[:average_line_length]}"
    puts "  - フィボナッチパターン比率: #{math[:fibonacci_pattern_ratio]}"
    puts
    puts "隠されたメッセージ: #{hidden_message}"
    puts
    puts "===== 生成された新しい詩 ====="
    puts generate_new_poem
  end
end

# コマンドライン引数からファイルを読み込むこともできます
if ARGV.length > 0 && File.exist?(ARGV[0])
  poem_text = File.read(ARGV[0])
  oracle = PoemOracle.new(poem_text)
  oracle.interpret
end

# 萩原朔太郎の「猫」を例として使用
HAGIWARA_CAT_POEM = <<~POEM
猫

まっくろけの猫が二匹

なやましいよるの家根のうえで、

ぴんとたてた尻尾のさきから、

糸のようなみかづきがかすんでいる。

『おわあ、こんばんは』

『おわあ、こんばんは』

『おぎやあ、おぎやあ、おぎやあ』
『おわああ、ここの家の主人は病気です』
POEM

# 例として萩原朔太郎の「猫」の解析を実行
puts "\n萩原朔太郎「猫」の解析例:"
example_oracle = PoemOracle.new(HAGIWARA_CAT_POEM)
example_oracle.interpret
