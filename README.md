# cesdecode.js

誰かがどこかでぜったい作ってるに決まってる文字コード変換関数です。
Shift_JIS 的なファイルをXHRでとってきて表示とかしたいときにすぐ使えるといいな。

## ビルド

makeとwgetとperlとcppが必要です。
make で成果物 cesdecode.js が生成されます。

### ビルド実行例

    % make
    wget -q -O med/CP932.TXT http://ftp.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT
    perl src/triejsonfromcodetable.pl < med/CP932.TXT > med/cp932.json
    wget -q -O med/sjis-0213-2004-std.txt http://x0213.org/codetable/sjis-0213-2004-std.txt
    perl src/triejsonfromcodetable.pl < med/sjis-0213-2004-std.txt > med/sjis2004.json
    wget -q -O med/euc-jis-2004-std.txt http://x0213.org/codetable/euc-jis-2004-std.txt
    perl src/triejsonfromcodetable.pl < med/euc-jis-2004-std.txt > med/eucjis2004.json
    discarding 8E => 008E
    discarding 8F => 008F
    /usr/bin/cpp -P -undef -Wundef -std=c99 -nostdinc -Wtrigraphs -fdollars-in-identifiers -C -I./med -I./src < src/cesdecode-impl.js > med/cesdecode-impl.js
    /usr/bin/cpp -P -undef -Wundef -std=c99 -nostdinc -Wtrigraphs -fdollars-in-identifiers -C -I./med < src/cesdecode.js > dist/cesdecode.js
    /usr/bin/cpp -P -undef -Wundef -std=c99 -nostdinc -Wtrigraphs -fdollars-in-identifiers -C -I./med -I./src < src/cesdecodecp932-impl.js > med/cesdecodecp932-impl.js
    /usr/bin/cpp -P -undef -Wundef -std=c99 -nostdinc -Wtrigraphs -fdollars-in-identifiers -C -I./med < src/cesdecodecp932.js > dist/cesdecodecp932.js

## 使用例

    <!DOCTYPE HTML>
    <html lang=ja>
        <head>
            <script src="cesdecode.js"></script> <!-- HTTPアクセス可能なところに置いてください -->
        </head>
        <body>
            <script>
                var req_uri = 'http://...'; // Shift_JIS的なファイル
                var req = new XMLHttpRequest();
                req.onreadystatechange = function () {
                    if (
                        req.readyState == 4 &&
                        req.status == 200
                    ) {
                        var response_data = new Uint8Array(req.response);
                        var text = cesdecode.fromcp932(response_data);
                        // text は変換済みの文字列なのであとは煮るなり焼くなり
                    }
                };
                req.open('GET', req_url);
                req.responseType = 'arraybuffer';
                req.send();
            </script>
        </body>
    </html>
