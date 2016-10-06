require('skeleton-css/css/skeleton.css');
require('font-awesome/css/font-awesome.css');
require('./index.html');

const data = require('./site');
const Elm = require('./Main.elm');

const mountNode = document.getElementById('main'); // eslint-disable-line no-undef
const app = Elm.Main.embed(mountNode);

setTimeout(() =>
  app.ports.data.send(data),
0);
