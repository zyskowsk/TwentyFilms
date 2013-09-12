class TwentyFilms.Views.UserEdit extends Backbone.View 
  template: JST['user_edit']

  events: 
    'keyup .edit-user-info' : 'userUpdateDebounce'

  render: ->
    @$el.html @template(currentUser: @model)
    this

  userUpdateDebounce: _.debounce (->
    @_updateUser()), 500

  _updateUser: ->
    formData = $('.edit-user-info').serializeJSON()
    @model.save(formData);
