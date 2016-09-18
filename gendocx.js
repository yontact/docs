var fs = require('fs');
const path = require('path');
var mkdirp = require('mkdirp');
var concat = require('concat-files');
var ncp = require('ncp').ncp;
var nodePandoc = require('node-pandoc');

Array.prototype.unique = function() {
  var n = {}, r = [];
  for (var i = 0; i < this.length; i++) {
    if (!n[this[i]]) {
      n[this[i]] = true;
      r.push(this[i]);
    }
  }
  return r;
}

var destdir = './_docx';
var imagesd = path.join(destdir, 'images');

mkdirp.sync(destdir);
mkdirp.sync(imagesd);

fs.readFile('SUMMARY.md', 'utf8', function (err, f) {
  var summary = f.split('\n').map(function (s) {
    return s.trim();
  }).filter(function (i) {
    if (i && i.length > 0 && i.startsWith('*')) {
      return i;
    }
  }).map(function (i) {
    return i.match(/^\* \[(.*)\]\((.*)\)$/)[2];
  });

  concat(['SUMMARY.md'].concat(summary), path.join(destdir, 'book.md'), function() {
    console.log('done');
  });

  var sectionDirs = summary.map(function (s) { return path.dirname(s); }).unique();
  var sectionImagesD = sectionDirs.map(function (sd) { return path.join(sd, 'images'); });
  sectionImagesD.map(function (d) {
    ncp(d, imagesd, function (err) {});
  });
});
