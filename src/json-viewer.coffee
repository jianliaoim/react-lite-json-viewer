
hsl = require 'hsl'
React = require 'react'
Immutable = require 'immutable'

reset = require './util/reset'
isSafari = require './util/is-safari'

Value = React.createFactory require './app/value'

{div} = React.DOM

T = React.PropTypes

module.exports = React.createClass
  displayName: 'lite-json-viewer'

  propTypes:
    data: T.instanceOf(Immutable.Collection).isRequired
    height: T.number.isRequired
    width: T.number
    path: T.instanceOf(Immutable.List).isRequired
    onChange: T.func.isRequired

  getDefaultProps: ->
    width: 800

  renderEntries: (stage, index) ->
    value = @props.data.getIn(stage)
    if value instanceof Immutable.Collection
      div style: @styleBlock(), key: index,
        value.keySeq().sort().map (entry, index) =>
          onClick = => @props.onChange stage.concat(entry)
          isActive = @props.path.get(stage.size) is entry
          div key: index, style: @styleEntry(isActive), onClick: onClick,
            Value value: entry
            Value value: value.get(entry)
    else
      Value value: value

  render: ->
    div style: @styleRoot(),
      if @props.data instanceof Immutable.Collection
        pathList = @props.path
        .map (stage, index) =>
          @props.path[..index]
        .unshift Immutable.List()
        div style: @styleTable(),
          pathList.map (path, index) =>
            @renderEntries path, index
      else
        div style: @styleBlock(),
          Value value: @props.data

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
    width: @props.width
    overflowX: 'auto'

  styleEntry: (isActive) ->
    display: if isSafari then '-webkit-flex' else 'flex'
    flexDirection: 'row'
    WebkitFlexDirection: 'row'
    alignItems: 'center'
    WebkitAlignItems: 'center'
    width: 'auto'
    padding: '4px 0px'
    backgroundColor: if isActive then hsl(80,80,90,0.2)
    color: 'white'
    cursor: 'pointer'

  styleBlock: ->
    fontFamily: reset.codeFonts
    overflowY: 'auto'
    minWidth: 100
    marginRight: 10
    paddingTop: 100
    paddingBottom: 200
    # scrollbar in Windows may look bad, so hide it
    overflowX: 'hidden'
    paddingRight: '2em'
    flexShrink: 0
