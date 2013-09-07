class TwentyFilms.Views.ResultsUsers extends Backbone.View
  template: JST['search/results_users']

  render: ->
    @$el.html @template()
    for user in @collection.models 
      userDetailView = new TwentyFilms.Views.SearchUserDetail(model: user)
      @$el.find('#user-details').append userDetailView.render().$el
    this