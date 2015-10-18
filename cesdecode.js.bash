# vi: set ft=javascript :

cat <<EOF
(function () {
if (! window.cesdecode) {
	window.cesdecode = {};
}
var _cesdecode = window.cesdecode;
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
cesdecode.decoderfromtrie = decoderfromtrie;
})();
EOF

#/*
for cesname in "$@"
do
#*/
cat <<EOF
(function () {
var _cesdecode = window.cesdecode;
var decoder = _cesdecode.decoderfromtrie($(cat ${cesname}.json));
cesdecode.decode$cesname = decoder;
})();
EOF
#/*
done
#*/
