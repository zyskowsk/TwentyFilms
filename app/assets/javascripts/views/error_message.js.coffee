class TwentyFilms.Views.ErrorMessage extends Backbone.View
  template: JST['error_messages']

  render: ->
    @$el.html @template(text: this.options.text)
    this