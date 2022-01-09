import { Elm } from './Main.elm'

console.log(`${__dirname}/../build`)
Elm.Main.init({
  node: document.getElementById('root'),
  flags: "My Elm Counter"
})
