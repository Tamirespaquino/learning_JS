var flatini = require("./")
  , tap = require("tap")
  , test = tap.test
  , fs = require("fs")
  , path = require("path")
  , fixture = path.resolve(__dirname, "fixture.ini")
  , data = fs.readFileSync(fixture, "utf8")
  , expectD =
    { o: 'p',
      'a with spaces': 'b  c',
      " xa  n          p ":'"\r\nyoyoyo\r\r\n',
      '[disturbing]': 'hey you never know',
      's': 'something',
      's1' : '\"something\'',
      's2': 'something else',
      'zr': ['deedee'],
      'ar': ['one', 'three', 'this is included'],
      'br': 'warm',
      a:
       { av: 'a val',
         e: '{ o: p, a: { av: a val, b: { c: { e: "this [value]" } } } }',
         j: '"{ o: "p", a: { av: "a val", b: { c: { e: "this [value]" } } } }"',
         "[]": "a square?",
         cr: ['four', 'eight']
       },
      'a.b.c': {
        e: '1',
        j: '2',
        nocomment: 'this\; this is not a comment',
        noHashComment: 'this\# this is not a comment'
      }
    }

test("parse file", function (t) {
  var d = flatini(data)
  t.deepEqual(d, expectD)
  t.end()
})
