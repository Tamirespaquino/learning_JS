# flatini
An ini parser without dot notation nesting. Ripped from the decoding half of 
https://github.com/isaacs/ini.

```ini
# inifile.conf

global=yes it is

[a.section]
arr[]=1
arr[]=2
arr[]=3
```

```js
// parse-conf.js

var flatini = require('./');
var fs = require('fs');

var parsed = flatini(fs.readFileSync('inifile.conf', 'utf8'));
console.log(parsed);
```

```shellsession
$ node parse-conf.js 
{ global: 'yes it is', 'a.section': { arr: [ '1', '2', '3' ] } }
$
```
