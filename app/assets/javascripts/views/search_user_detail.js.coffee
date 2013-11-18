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
      from: 'Search Bar'

    @model.follow()
    @render()

  unfollow: ->
    mixpanel.track 'Unfollow User',
      from: 'Search Bar'
      
    @model.unfollow()
    @render()
