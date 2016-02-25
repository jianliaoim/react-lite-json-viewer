
hsl = require 'hsl'
React = require 'react'
Immutable = require 'immutable'

reset = require './util/reset'
jianliao = require '../data/jianliao.json'

JsonViewer = React.createFactory require './json-viewer'
{div, span, a} = React.DOM

link = 'https://github.com/teambition/react-lite-json-viewer'

module.exports = React.createClass
  displayName: 'app-page'

  getInitialState: ->
    path: Immutable.List()

  onPathChange: (path) ->
    @setState {path}

  render: ->
    div className: 'app-page',
      div style: @styleNote(),
        span null, 'JSON view in React, try clicks! Found more on '
        a style: @styleLink(), href: link, 'GitHub'
      JsonViewer
        height: 500
        width: window.innerWidth - 200
        data: Immutable.fromJS(jianliao)
        path: @state.path
        onChange: @onPathChange

  styleNote: ->
    color: 'white'
    fontFamily: reset.contentFonts
    marginBottom: 40
    fontSize: '14px'

  styleLink: ->
    color: hsl 240, 80, 80
