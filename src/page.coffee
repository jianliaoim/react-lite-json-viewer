
React = require 'react'
Immutable = require 'immutable'

jianliao = require '../data/jianliao.json'

JsonViewer = React.createFactory require './json-viewer'
div = React.createFactory 'div'

module.exports = React.createClass
  displayName: 'app-page'

  getInitialState: ->
    path: Immutable.List()

  onPathChange: (path) ->
    @setState {path}

  render: ->
    div className: 'app-page',
      JsonViewer
        height: 500
        data: Immutable.fromJS(jianliao)
        path: @state.path
        onChange: @onPathChange
