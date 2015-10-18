# vi: set ft=javascript :

cat <<EOF
var cesdecode = {};
(function () {
var decoderfromtrie = function(trie) {
	return function(bytes) {
		var s = '';
		var t = trie;
		for (var i = 0; i < bytes.length; ++i) {
			var b = bytes[i];
			var tt = t[b];
			if (typeof(tt) === 'string') {
				// leaf of the trie; emit and reset
				s += tt;
				t = trie;
			} else if (typeof(tt) === 'object') {
				// retrieve the trie
				t = tt;
			} else {
				// no entry; ignore and reset
				t = trie;
			}
		}
		return s;
	};
};

var decodecp932 = decoderfromtrie( $(cat cp932.json) );
var decodesjis2004 = decoderfromtrie( $(cat sjis2004.json ) );
var decodeeucjis2004 = decoderfromtrie( $(cat eucjis2004.json ) );

cesdecode.decoderfromtrie = decoderfromtrie;
cesdecode.decodecp932 = decodecp932;
cesdecode.decodesjis2004 = decodesjis2004;
cesdecode.decodeeucjis2004 = decodeeucjis2004;
})();
EOF
