bar = require "./bar"
templates = require "./templates"
State = require "ampersand-state"
View = require "ampersand-view"

Person = State.extend
  props:
    name: "string"
    dancing: "boolean"

person = new Person {name: "moser 2"}
person.on "change:dancing", () -> console.log "#{@name} is dancing"
person.dancing = true

LeView = View.extend
  template: templates.base
  bindings:
    "model.name": "[data-hook=name]"
  events:
    "click [data-hook=act]": "act"
    "touchstart .swipable": "touch"
  act: (evt) ->
    console.log evt
    person.name = person.name + "hurz"
    person.dancing = !person.dancing
  touch: (evt) ->
    console.log evt
    person.name = evt.toString()

v = new LeView {el: document.getElementById("container"), model: person}
v.render()
