require 'set'

class MethodPoem
  Dirs = {l:[1, 0], r:[-1, 0], u:[0, 1], d:[0, -1]}
  Revs = {l: :r, r: :l, u: :d, d: :u}
  @@tomb, @@dead = {}, Set.new

  class Object
    def method_missing(m, *a) @@dead === m.to_s ? @@tomb[m.to_s] : super end
  end

  def self.recite
    w, h = (require 'io/console'; IO.console.winsize.reverse) rescue [70, 25]
    h -= 12; boxW = [w-2, 2].max
    f = w * h / 800.0
    frq = [0.4 * f, 0.5].min

    movings, log, origs = [], [], {}
    methods = ObjectSpace.each_object(Class).each_with_object({}) {|k, h|
      next if k.name == nil
      (k.instance_methods(false) + k.methods(false)).each{|m|
        h[m.to_s] = k.name
        origs[m.to_s] = k.name
      }
    }.keys.uniq

    system 'clear'
    loop do
      if movings.size < [10 * f, 5].max && rand < frq && methods.any?
        m = methods.sample
        d = Dirs.keys.sample
        p = d == :l ? [-(m.size), rand(h)] : d == :r ? [w, rand(h)] : d == :u ? [rand(boxW), -(m.size)] : [rand(boxW), h+m.size]
        movings << {m: m, dir: d, chs: m.chars.map.with_index{|ch, i| {ch: ch, pos: [p[0] + i * (d == :u || d == :d ? 0 : Dirs[d][0]), p[1] + i * (d == :l || d == :r ? 0 : Dirs[d][1])]}}}
      end

      canv = Array.new(h){' ' * w}
      poss, heads = {}, {}
      movings.each do |m|
        m[:chs].each_with_index do |ch, i|
          x, y = ch[:pos].map(&:to_i)
          next if x < 0 || x >= w || y < 0 || y >= h
          p = [x, y]
          poss[p] ||= []
          poss[p] << m

          if i == 0
            heads[p] ||= []
            heads[p] << m
          end
          
          canv[y][x] = /u|d/ =~ m[:dir] && ch[:ch] == '_' ? '-' : ch[:ch]
        end
      end

      colls = []
      heads.each do |p, mds|
        mds.each do |m|
          poss[p].reject{|_m| _m == m}.uniq.each do |_m|
            colls << [m, _m]
          end
        end
      end

      colls.each do |eater, eaten|
        movings.delete eaten
        methods.delete eaten[:m]
        @@dead << eaten[:m]
        e = "#{origs[eaten[:m]]||'?'}##{eaten[:m]}"
        @@tomb[eaten[:m]] = e
        log.push "`#{eater[:m]}` ate `#{eaten[:m]}`: #{e} is gone"
        log.shift if log.size > 4
      end

      movings.each do |m|
        m[:dir] = Dirs.keys.sample if rand < 0.03 && m[:dir] != Revs[m[:dir]]
        x, y = Dirs[m[:dir]]
        t = m[:chs].map{|ch| ch[:pos].dup}
        m[:chs][0][:pos] = [t[0][0] + x, t[0][1] + y]
        1.upto(m[:chs].size-1){|i| m[:chs][i][:pos] = t[i-1]}
      end

      print "\033[H\033[2J", "+" + "-"*boxW + "+"
      canv.each{|c| puts "|#{c[0...boxW]}#{' '*[boxW-c[0...boxW].size, 0].max}|"}
      puts "+#{'-'*boxW}+", "#{methods.size} methods"
      log.each{|l| puts l}
      movings.reject!{|m| m[:chs].all?{|ch|
        x, y = ch[:pos].map(&:to_i)
        x < 0 || x >= w || y < 0 || y >= h
      }}
      break if methods.empty?
      sleep 0.08
    end
  rescue => e; puts "!#{e}"
  end
end

MethodPoem.recite
