module.exports = function (conf, name) {
  var env = {};
  var k;

  for (k in conf) {
    if (k.toUpperCase() == k) env[k] = conf[k];
  }

  if (conf[name]) {
    for (k in conf[name]) {
      if (k.toUpperCase() == k) env[k] = conf[name][k];
    }
  }

  return env;
};
