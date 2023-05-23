#このプログラムを以下のコマンドで実行すると答えがわかる。
# ruby main.rb input.txt | grep 'FLAG'

#デバックするときは以下のコマンドで実行する。
# DEBUG=true ruby main.rb input.txt
require 'debug'

#入力を処理する。
c=readline.chomp
len=c.length

#文字の番号と文字の対応を作る。
upper=("A".."Z").to_a.each_with_index.to_a.to_h
lower=("a".."z").to_a.each_with_index.to_a.to_h
len_abc=upper.length
#番号と文字を入れ替える。
inv_upper=upper.invert
inv_lower=lower.invert

#カエサル暗号を復号する。
(-25..25).each do |k|
    #答えを格納する変数を宣言。
    ans=Array.new(len)
    (0..len-1).each do |i|
        binding.break if ENV.fetch("DEBUG",false)
        if [" ",",","."].include?(c[i]) #ピリオドと句点と空白はそのまま返す。
            ans[i]=c[i]
            next  #次へ
        end
        if c[i]==c[i].upcase #大文字のとき
            nex=upper[c[i]]
            nex=(nex+k).modulo(len_abc)
            ans[i]=inv_upper[nex]
        else #小文字のとき
            nex=lower[c[i]]
            nex=(nex+k).modulo(len_abc)
            ans[i]=inv_lower[nex]
        end
    end
    
    puts "#{k}: #{ans.join}"
end

binding.break if ENV.fetch("DEBUG",false)