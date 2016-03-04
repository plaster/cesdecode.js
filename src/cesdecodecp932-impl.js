function () {
var cesdecode = {};
cesdecode.decoderfromtrie =
#include "decoder-from-trie.js"
;
cesdecode.fromcp932 = cesdecode.decoderfromtrie(
#include "med/cp932.json"
);
	return cesdecode;
}
