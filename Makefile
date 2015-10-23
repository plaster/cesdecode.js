all: dist/cesdecode.js dist/cesdecodecp932.js
dist/cesdecode.js: cesdecode.js.bash med/cp932.json med/sjis2004.json med/eucjis2004.json
	mkdir -p dist
	bash cesdecode.js.bash cp932 sjis2004 eucjis2004 > $@
dist/cesdecodecp932.js: cesdecode.js.bash med/cp932.json
	mkdir -p dist
	bash cesdecode.js.bash cp932 > $@
.PHONY: clean
clean:
	rm -f dist/cesdecode.js dist/cesdecodecp932.js med/cp932.json med/sjis2004.json med/eucjis2004.json
clean-all: clean
	rm -f med/CP932.TXT med/sjis-0213-2004-std.txt med/euc-jis-2004-std.txt

med/CP932.TXT:
	mkdir -p med
	wget -q -O $@ http://ftp.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT
med/sjis-0213-2004-std.txt:
	mkdir -p dist
	wget -q -O $@ http://x0213.org/codetable/sjis-0213-2004-std.txt
med/euc-jis-2004-std.txt:
	mkdir -p dist
	wget -q -O $@ http://x0213.org/codetable/euc-jis-2004-std.txt
med/cp932.json: med/CP932.TXT
	mkdir -p dist
	perl triejsonfromcodetable.pl < $< > $@
med/sjis2004.json: med/sjis-0213-2004-std.txt
	mkdir -p dist
	perl triejsonfromcodetable.pl < $< > $@
med/eucjis2004.json: med/euc-jis-2004-std.txt
	mkdir -p dist
	perl triejsonfromcodetable.pl < $< > $@
