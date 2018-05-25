list = ""

# CLIで引数指定
ARGV.each_index do |i|
  v = ARGV[i]
  # 引数の形を正規表現でチェック
  if v =~ /^[0-9]+\:.*$/
    # stringをparseしてarrayからハッシュに変換
    v_array = v.delete(' ').split(/[:,]/)
    v_hash = v_array.each_slice(2).map { |k, v| [k.to_i, v.to_s] }.to_h
    v_hash.each do |key, value| # keyとvalueに分ける
      # 一番後ろの引数が数値かどうかを判断
      if ARGV[-1] =~ /^[0-9]+$/
        if (ARGV[-1].to_i % key) == 0 # 数値ならkeyの数値で割り切れるか判断
          list = list + value # 割り切れたら文字列を後ろにappend
          break
        else
          list = key # 割り切れなかったらそのまま数値を代入
          break
        end
      else
        list = "Invalid Input" # 数値じゃないならエラー
      end
    end
  elsif v !=~ /^[0-9]+\:.*$/ && i != (ARGV.length - 1) # 引数が指定の形じゃない
    list = "Invalid Input"
  elsif v !=~ /^[0-9]+\:.*$/ && i == (ARGV.length - 1)
    if list.to_s.include?("Invalid Input")
      list = "Invalid Input"
    else
      break
    end
    break
  end
end

puts list
