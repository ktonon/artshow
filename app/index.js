require('ace-css/css/ace.min.css');
require('font-awesome/css/font-awesome.css');
require('./index.html');

const doc = document; // eslint-disable-line no-undef
const data = require('./site');
const Elm = require('./Main.elm');

const font = doc.createElement('link');
font.setAttribute('href', `https://fonts.googleapis.com/css?family=${data.font}`);
font.setAttribute('rel', 'stylesheet');
doc.head.appendChild(font);

const mountNode = doc.getElementById('main');
const app = Elm.Main.embed(mountNode);

setTimeout(() =>
  app.ports.data.send(data),
0);
