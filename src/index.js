import '@fortawesome/fontawesome-free/css/svg-with-js.min.css'
import 'bootstrap/dist/css/bootstrap-reboot.min.css'
import './global.scss'
import { Elm } from './Main.elm'

console.log(`${__dirname}/../build`)
Elm.Main.init({
  node: document.getElementById('root'),
  flags: "My Elm Counter"
})
