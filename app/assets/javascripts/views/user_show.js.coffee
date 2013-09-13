 class TwentyFilms.Views.UserShow extends Backbone.View

  template: JST['user_show']

  events:
    'click .show.back': 'navigateHome'
    'click #toggle-follow-user': 'toggleFollow'

  render: ->
    @$el.html @template(user: @model)
    button = @$el.find('#toggle-follow-user')

    if @model.isFollowed()
      button.html('unfollow')
      button.removeClass()
      button.addClass('unfollow')
    else
      button.html('follow')
      button.removeClass()
      button.addClass('follow')

    @model.get('films').each (film) =>
      detailView = new TwentyFilms.Views.ListDetail(model: film)
      @$el.find('.list').append detailView.render().$el

    followsView = new TwentyFilms.Views.UserFollows(model: @model)
    @$el.find('.user_show_follows').append followsView.render().$el

    this

  toggleFollow: ->
    if $('#toggle-follow-user').attr('class') == 'follow'
      @model.follow()
      $('#toggle-follow-user').html('unfollow')
      $('#toggle-follow-user').removeClass()
      $('#toggle-follow-user').addClass('unfollow')
    else
      @model.unfollow()
      $('#toggle-follow-user').html('follow')
      $('#toggle-follow-user').removeClass()
      $('#toggle-follow-user').addClass('follow')
