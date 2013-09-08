class TwentyFilms.Views.UserFollows extends Backbone.View

  template: JST['user_follows']

  render: -> 
    @$el.html @template()
    this