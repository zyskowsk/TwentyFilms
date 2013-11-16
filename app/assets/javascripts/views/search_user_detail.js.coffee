class TwentyFilms.Views.SearchUserDetail extends Backbone.View

  template: JST['search/user_detail']

  events: 
    'click #follow': 'follow'
    'click #unfollow': 'unfollow'

  render: ->
    @$el.html @template(user: @model)
    this

  follow: ->
    mixpanel.track 'Follow User',
      origin: 'Search Bar'

    @model.follow()
    @render()

  unfollow: ->
    mixpanel.track 'Unfollow User',
      origin: 'Search Bar'
      
    @model.unfollow()
    @render()
