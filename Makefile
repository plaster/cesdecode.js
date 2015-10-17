cesdecode.js: cesdecode.js.bash cp932.json sjis2004.json eucjis2004.json
	bash cesdecode.js.bash > $@
.PHONY: clean
clean:
	rm -f cesdecode.js cp932.json sjis2004.json eucjis2004.json
clean-all: clean
	rm -f CP932.TXT sjis-0213-2004-std.txt euc-jis-2004-std.txt

CP932.TXT:
	wget -O $@ http://ftp.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT
sjis-0213-2004-std.txt:
	wget -O $@ http://x0213.org/codetable/sjis-0213-2004-std.txt
euc-jis-2004-std.txt:
	wget -O $@ http://x0213.org/codetable/euc-jis-2004-std.txt
cp932.json: CP932.TXT
	perl triejsonfromcodetable.pl < $< > $@
sjis2004.json: sjis-0213-2004-std.txt
	perl triejsonfromcodetable.pl < $< > $@
eucjis2004.json: euc-jis-2004-std.txt
	perl triejsonfromcodetable.pl < $< > $@
