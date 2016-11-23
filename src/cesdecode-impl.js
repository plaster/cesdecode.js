function () {
var cesdecode = {};
cesdecode.decoderfromtrie =
#include "decoder-from-trie.js"
;
#include "copyright-and-permission-unicode"
cesdecode.fromcp932 = cesdecode.decoderfromtrie(
#include "med/cp932.json"
);
cesdecode.fromsjis2004 = cesdecode.decoderfromtrie(
#include "med/sjis2004.json"
);
cesdecode.fromeucjis2004 = cesdecode.decoderfromtrie(
#include "med/eucjis2004.json"
);
	return cesdecode;
}
