CPP=/usr/bin/cpp -P -undef -Wundef -std=c99 -nostdinc -Wtrigraphs -fdollars-in-identifiers -C

all: dist/cesdecode.js dist/cesdecodecp932.js

dist/cesdecode.js: src/cesdecode.js med/cesdecode-impl.js
	@mkdir -p dist
	$(CPP) -I./med < $< > $@

dist/cesdecodecp932.js: src/cesdecodecp932.js med/cesdecodecp932-impl.js
	@mkdir -p dist
	$(CPP) -I./med < $< > $@

med/cesdecode-impl.js: src/cesdecode-impl.js med/cp932.json med/sjis2004.json med/eucjis2004.json
	@mkdir -p dist
	$(CPP) -I./med -I./src < $< > $@

med/cesdecodecp932-impl.js: src/cesdecodecp932-impl.js med/cp932.json
	@mkdir -p dist
	$(CPP) -I./med -I./src < $< > $@

.PHONY: clean
clean:
	rm -f \
		dist/cesdecode.js     dist/cesdecodecp932.js \
		med/cesdecode-impl.js med/cesdecodecp932-impl.js \
		med/cp932.json med/sjis2004.json med/eucjis2004.json
clean-all: clean
	rm -f med/CP932.TXT med/sjis-0213-2004-std.txt med/euc-jis-2004-std.txt

med/CP932.TXT:
	@mkdir -p med
	wget -q -O $@ http://ftp.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT
med/sjis-0213-2004-std.txt:
	@mkdir -p med
	wget -q -O $@ http://x0213.org/codetable/sjis-0213-2004-std.txt
med/euc-jis-2004-std.txt:
	@mkdir -p med
	wget -q -O $@ http://x0213.org/codetable/euc-jis-2004-std.txt
med/cp932.json: med/CP932.TXT
	@mkdir -p med
	perl src/triejsonfromcodetable.pl < $< > $@
med/sjis2004.json: med/sjis-0213-2004-std.txt
	@mkdir -p med
	perl src/triejsonfromcodetable.pl < $< > $@
med/eucjis2004.json: med/euc-jis-2004-std.txt
	@mkdir -p med
	perl src/triejsonfromcodetable.pl < $< > $@
