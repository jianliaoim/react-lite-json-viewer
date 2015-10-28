React = require 'react'
Immutable = require 'immutable'
isSafari = require './util/is-safari'

{div, span, pre} = React.DOM

typeColor =
  list: 'rgba(245, 222, 179, .8)'
  map: 'rgba(223, 245, 179, .8)'

T = React.PropTypes

module.exports = React.createClass
  displayName: 'json-viewer'

  propTypes:
    data: T.any
    height: T.number
    path: T.instanceOf(Immutable.List)
    onChange: T.func

  filterType: (value) ->
    if value instanceof Immutable.Map
      'map'
    else if value instanceof Immutable.List
      'list'
    else
      JSON.stringify value

  renderKeys: (stage) ->
    value = @props.data.getIn(stage)
    if value instanceof Immutable.Collection
      div style: @styleBlock(),
        value.keySeq().sort().map (entry, index) =>
          onClick = => @props.onChange stage.concat(entry)
          isActive = @props.path.get(stage.size) is entry
          div key: index, style: @styleEntries(isActive), onClick: onClick,
            span style: @styleKey(), entry
            span style: @styleValue(stage.concat(entry)), @filterType value.get(entry)

  render: ->
    div style: @styleRoot(),
      if @props.data instanceof Immutable.Collection
        pathList = @props.path
        .map (stage, index) =>
          @props.path[..index]
        .unshift Immutable.List()
        div style: @styleTable(),
          pathList.map (path) =>
            @renderKeys path
      else
        pre style: @styleBlock(),
          if @props.data? then @props.data else 'null'

  styleRoot: ->
    flex: 1
    WebkitFlex: 1

  styleTable: ->
    display: if isSafari then '-webkit-flex' else 'flex'
    flexDirection: 'row'
    WebkitFlexDirection: 'row'
    flex: 1
    WebkitFlex: 1
    height: @props.height

  styleEntries: (isActive) ->
    display: if isSafari then '-webkit-flex' else 'flex'
    flexDirection: 'row'
    WebkitFlexDirection: 'row'
    width: 'auto'
    overflowY: 'auto'
    overflowX: 'visible'
    padding: '10px'
    color: if isActive then '#D45502' else '#FFF'
    cursor: 'pointer'

  styleKey: ->
    flex: 1
    WebkitFlex: 1
    padding: '0 10px'
    lineHeight: '24px'
    fontSize: '12px'
    display: 'inline-block'
    marginRight: '10px'
    marginBottom: '6px'

  styleValue: (path) ->
    flex: '0 0 auto'
    WebkitFlex: '0 0 auto'
    margin: 0
    overflowY: 'auto'
    fontSize: '12px'
    padding: '0 10px'
    fontFamily: 'Menlo, Consolas, Ubuntu Mono, monospace'
    backgroundColor: typeColor[@filterType(@props.data.getIn(path))]

  styleBlock: ->
    fontFamily: 'Menlo, Consolas, Ubuntu Mono, monospace'
    overflowY: 'scroll'
    backgroundColor: 'rgba(245, 245, 245, 0.2)'
    minWidth: 200
    marginRight: 10
