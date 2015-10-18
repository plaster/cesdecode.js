# cesdecode.js

誰かがどこかでぜったい作ってるに決まってる文字コード変換関数です。
Shift_JIS 的なファイルをXHRでとってきて表示とかしたいときにすぐ使えるといいな。

作者はイマドキのJSしらないのでモジュール化の作法とかもぜんぜんわかってません。ツッコミくれるとうれしいな！

## ビルド

makeとwgetとperlとbashが必要です。
make で成果物 cesdecode.js が生成されます。

### ビルド実行例

    % make

      wget -O CP932.TXT http://ftp.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT
      --2015-10-18 19:41:06--  http://ftp.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT
      ftp.unicode.org (ftp.unicode.org) をDNSに問いあわせています... 216.97.88.9
      ftp.unicode.org (ftp.unicode.org)|216.97.88.9|:80 に接続しています... 接続しました。
      HTTP による接続要求を送信しました、応答を待っています... 200 OK
      長さ: 295324 (288K) [text/plain]
      `CP932.TXT' に保存中
      
      100%[===============================================>] 295,324      232K/s 時間 1.2s    
      
      2015-10-18 19:41:07 (232 KB/s) - `CP932.TXT' へ保存完了 [295324/295324]
      
      perl triejsonfromcodetable.pl < CP932.TXT > cp932.json
      wget -O sjis-0213-2004-std.txt http://x0213.org/codetable/sjis-0213-2004-std.txt
      --2015-10-18 19:41:08--  http://x0213.org/codetable/sjis-0213-2004-std.txt
      x0213.org (x0213.org) をDNSに問いあわせています... 59.106.19.103
      x0213.org (x0213.org)|59.106.19.103|:80 に接続しています... 接続しました。
      HTTP による接続要求を送信しました、応答を待っています... 200 OK
      長さ: 319198 (312K) [text/plain]
      `sjis-0213-2004-std.txt' に保存中
      
      100%[===============================================>] 319,198     --.-K/s 時間 0.06s   
      
      2015-10-18 19:41:08 (5.43 MB/s) - `sjis-0213-2004-std.txt' へ保存完了 [319198/319198]
      
      perl triejsonfromcodetable.pl < sjis-0213-2004-std.txt > sjis2004.json
      wget -O euc-jis-2004-std.txt http://x0213.org/codetable/euc-jis-2004-std.txt
      --2015-10-18 19:41:08--  http://x0213.org/codetable/euc-jis-2004-std.txt
      x0213.org (x0213.org) をDNSに問いあわせています... 59.106.19.103
      x0213.org (x0213.org)|59.106.19.103|:80 に接続しています... 接続しました。
      HTTP による接続要求を送信しました、応答を待っています... 200 OK
      長さ: 324237 (317K) [text/plain]
      `euc-jis-2004-std.txt' に保存中
      
      100%[===============================================>] 324,237     --.-K/s 時間 0.07s   
      
      2015-10-18 19:41:08 (4.27 MB/s) - `euc-jis-2004-std.txt' へ保存完了 [324237/324237]
      
      perl triejsonfromcodetable.pl < euc-jis-2004-std.txt > eucjis2004.json
      discarding 8E => 008E
      discarding 8F => 008F
      bash cesdecode.js.bash > cesdecode.js

