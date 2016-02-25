
hsl = require 'hsl'
React = require 'react'
assign = require 'object-assign'
Immutable = require 'immutable'

reset = require '../util/reset'

{div, span} = React.DOM

stringify = JSON.stringify

module.exports = React.createClass
  displayName: 'view-value'

  propTypes:
    value: React.PropTypes.any

  renderString: ->
    span style: @styleString(), stringify(@props.value)

  renderNumber: ->
    span style: @styleNumber(), @props.value

  renderBoolean: ->
    span style: @styleBoolean(), stringify(@props.value)

  renderUndefined: ->
    span style: @styleUndefined(), 'undefined'

  renderNull: ->
    span style: @styleNull(), 'null'

  renderMap: ->
    span style: @styleMap(), "Map #{@props.value.size}"

  renderList: ->
    span style: @styleList(), "List #{@props.value.size}"

  render: ->
    value = @props.value
    type = typeof value

    switch
      when type is 'string' then @renderString()
      when type is 'number' then @renderNumber()
      when type is 'boolean' then @renderBoolean()
      when value is undefined then @renderUndefined()
      when value is null then @renderNull()
      when Immutable.Map.isMap value then @renderMap()
      when Immutable.List.isList value then @renderList()
      else @renderUnknown()

  styleBase: (more) ->
    baseStyle =
      lineHeight: '24px'
      height: '24px'
      fontSize: '12px'
      padding: '0 10px'
      fontFamily: reset.codeFonts
      overflowX: 'hidden'
      whiteSpace: 'nowrap'
      textOverflow: 'ellipsis'
      color: hsl 0, 0, 90
      flexShrink: 0
      WebkitFlexShrink: 0
    assign more, baseStyle

  styleString: ->
    @styleBase backgroundColor: hsl 0, 0, 40, 0.2

  styleNumber: ->
    @styleBase backgroundColor: hsl 240, 30, 40, 0.3

  styleBoolean: ->
    @styleBase backgroundColor: hsl 240, 50, 30, 0.3

  styleNull: ->
    @styleBase backgroundColor: hsl 140, 40, 70, 0.2

  styleUndefined: ->
    @styleBase backgroundColor: hsl 140, 40, 70, 0.2

  styleMap: ->
    @styleBase backgroundColor: hsl 200, 70, 60, 0.3

  styleList: ->
    @styleBase backgroundColor: hsl 40, 70, 70, 0.3
