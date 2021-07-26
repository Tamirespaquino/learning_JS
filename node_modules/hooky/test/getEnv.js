var flatini = require('flatini');
var fs = require('fs');
var getEnv = require('../getEnv');
var test = require('tap').test;


test('get expected env from conf', function (t) {
  var conf = flatini(fs.readFileSync(__dirname + '/hooky.conf', 'utf8'));
  t.equal(JSON.stringify(getEnv(conf, 'example.com')), '{"ENV":"prod","PORT":"2347","WIZBANG":"xt3fe596"}', 'output matches');
  t.end();
});
