class TwentyFilms.Views.SearchUserDetail extends Backbone.View
  tagName: 'li'
  template: JST['search/user_detail']

  events: 
    'click #follow': 'follow'
    'click #unfollow': 'unfollow'

  render: ->
    @$el.html @template(user: @model)
    this 

  follow: ->
    @model.follow()
    TwentyFilms.Store.currentUser.get('followed_users').add(@model)
    @render()

  unfollow: ->
    @model.unfollow()
    TwentyFilms.Store.currentUser.get('followed_users').remove(@model)
    @render()