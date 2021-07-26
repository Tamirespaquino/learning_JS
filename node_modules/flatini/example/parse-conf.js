// parse-conf.js

var flatini = require('./');
var fs = require('fs');

var parsed = flatini(fs.readFileSync('inifile.conf', 'utf8'));
console.log(parsed);
