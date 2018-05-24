list = ""

ARGV.each_index do |i|
  v = ARGV[i]
  # 引数の形を正規表現でチェック
  if v =~ /^[0-9]+\:.*$/
    # stringをparseしてarrayからハッシュに変換
    v_array = v.delete(' ').split(/[:,]/)
    v_hash = v_array.each_slice(2).map { |k, v| [k.to_i, v.to_s] }.to_h
    v_hash.each do |key, value|
      # 数値かどうかを判断
      if ARGV[-1] =~ /^[0-9]+$/
        if (ARGV[-1].to_i % key) == 0
          list = list + value
          break
        else
          list = key
          break
        end
      else
        list = "Invalid Input"
      end
    end
  elsif v !=~ /^[0-9]+\:.*$/ && i != (ARGV.length - 1)
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
