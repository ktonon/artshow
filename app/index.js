// import 'skeleton.css';
// import 'font-awesome/css/font-awesome.css';
import Elm from './Main.elm';

const mountNode = document.getElementById('main'); // eslint-disable-line no-undef
Elm.Main.embed(mountNode);
