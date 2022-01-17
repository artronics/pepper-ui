import '@fortawesome/fontawesome-free/css/svg-with-js.min.css'
import './global.scss'
import { Elm } from './Main.elm'

const flags = {
  windowSize: {
    w: window.innerWidth,
    h: window.innerHeight
  }
}

Elm.Main.init({
  node: document.getElementById('root'),
  flags: flags
})
