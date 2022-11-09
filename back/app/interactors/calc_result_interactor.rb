class CalcResultInteractor
  include Interactor

  def call
    male_visual = context.male_visual.map { |s| s * 2 }
    male_het = context.male_het.map { |s| s + s.downcase }
    female_visual = context.female_visual.map { |s| s * 2 }
    female_het = context.female_het.map { |s| s + s.downcase }
    
    male = male_visual + male_het
    female = female_visual + female_het
    # -------------------------------------------
    # 共通の遺伝子
    bilateral_gene = []
    male.each do |m|
      female.each do |f|
        if m.downcase == f.downcase
          bilateral_gene.push(m, f)
        end
      end
    end
    male = male - bilateral_gene
    female = female - bilateral_gene
    # -------------------------------------------
    # 片方しか持っていない遺伝子の小文字2つを作成
    unilateral_gene = male + female
    downcased_unilateral_gene = []
    unilateral_gene.length.times do |n|
      downcased_unilateral_gene.push(unilateral_gene[n].downcase)
    end

    all_gene = []
    unilateral_gene.length.times do |n|
      all_gene.push(unilateral_gene[n], downcased_unilateral_gene[n])
    end
    # -------------------------------------------
    # 最終的な組み合わせの配列を作成
    all_gene += bilateral_gene
    # -------------------------------------------
    # ホワイトアウトを"WW"から"Ww"に変換
    if all_gene.include?("WW")
      all_gene.count("WW").times do
        all_gene[all_gene.find_index("WW")] = "Ww"
      end
    end
    # -------------------------------------------
    # ↑をモルフごとに分割
    all_gene = all_gene.each_slice(2).to_a
    # -------------------------------------------
    # 一文字ずつに分割
    separated_arr = []
    all_gene.each do |x|
      separated_arr << [x[0].chars, x[1].chars]
    end
    separated_arr
    # -------------------------------------------
    # 文字を全パターンかける
    result_arr = []
    separated_arr.each do |x|
      result_arr << x[0][0] + x[1][0]
      result_arr << x[0][0] + x[1][1]
      result_arr << x[0][1] + x[1][0]
      result_arr << x[0][1] + x[1][1]
    end
    # -------------------------------------------
    # 小文字大文字の順になっているものを大文字小文字の順番に変換
    result_arr.map!{|a| a.chars.sort.join}
    result_arr = result_arr.each_slice(4).to_a
    result_arr.map!(&:sort)
    # -------------------------------------------
    # 全組み合わせ計算
    i = 0
    while i < result_arr.length - 1 do
      if i == 0
        all_patterns = result_arr[i].product(result_arr[i + 1])
      else
        all_patterns = all_patterns.product(result_arr[i + 1])
      end
      i += 1
    end
    all_patterns.map!{|a| a.join.scan(/.{1,#{2}}/)}
    # -------------------------------------------
    # パターン毎に集計
    pattern_count = all_patterns.group_by(&:itself).map{|k, v| [k, v.size]}.to_h
    # -------------------------------------------
    # パターン数を最大公約数で割り、可能性の分母と分子を算出
    counts = pattern_count.values.uniq
    gcd = 0
    if counts.length == 1
      gcd = counts[0]
    elsif counts.length > 1
      counts.length - 1.times do |n|
        gcd = counts[n].gcd(counts[n + 1])
      end
    end
    denominator = pattern_count.values.sum / gcd
    pattern_count = pattern_count.map{|k, v| [k, v / gcd]}.to_h
    # -------------------------------------------
    # 表現とヘテロの判定
    morph_data = Morph.pluck(:name, :symbol)
    morph_names = morph_data.map { |ar| ar[0]}
    morph_symbols = morph_data.map { |ar| ar[1]}
    upper = ('A'..'Z')
    lower = ('a'..'z')
    result_arr = pattern_count.keys.map do |ar|
      visual = []
      het = []
      ar.each do |s|
        if s[0,1] == "W"
          visual << morph_names[morph_symbols.index(s[0, 1])]
        elsif upper.include?(s[0,1]) && upper.include?(s[1,1])
          visual << morph_names[morph_symbols.index(s[0, 1])]
        elsif upper.include?(s[0,1]) && lower.include?(s[1,1])
          het << morph_names[morph_symbols.index(s[0, 1])]
        end
      end
      [[:visual, visual], [:het, het]]
    end
    result_arr.map!{|x| x.to_h}
    # -------------------------------------------
    # 可能性を算出
    i = 0
    while i < result_arr.length do
      result_arr[i][:possibility] = pattern_count.values[i].quo(denominator).to_f * 100
      i += 1
    end
    context.result = result_arr
  end
end