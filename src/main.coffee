
React = require 'react'
ReactDOM = require 'react-dom'

Page = React.createFactory require './page'

ReactDOM.render Page(), document.querySelector('.demo')
