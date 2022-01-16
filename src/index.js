import '@fortawesome/fontawesome-free/css/svg-with-js.min.css'
import './global.scss'
import { Elm } from './Main.elm'

const flags = {
  windowSize: {
    width: window.innerWidth,
    height: window.innerHeight
  }
}

Elm.Main.init({
  node: document.getElementById('root'),
  flags: flags
})
