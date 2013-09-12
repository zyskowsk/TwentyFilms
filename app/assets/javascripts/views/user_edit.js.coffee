class TwentyFilms.Views.UserEdit extends Backbone.View 
  template: JST['user_edit']
  currentErrors: []

  events: 
    'keyup .edit-user-info' : 'userUpdateDebounce'
    'submit' : 'updatePassword'

  userUpdateDebounce: _.debounce (->
    @_updateUser()), 500

  render: ->
    @$el.html @template(currentUser: @model)
    this

  updatePassword: (event) ->
    event.preventDefault()
    formData = $(event.target).serializeJSON()
    @model.save formData,
      success: (model, response) =>
        @render()
        for error in @currentErrors
          error.remove()
        errorView = new TwentyFilms.Views.ErrorMessage(text: "password successfully reset")
        @currentErrors.push(errorView)
        $('#root').append errorView.render().$el
        $('.error-message h5').fadeIn('slow')
      error: (model, response) =>
        for error in @currentErrors
          error.remove()
        errors = JSON.parse(response.responseText)
        for error in errors
          errorView = new TwentyFilms.Views.ErrorMessage(text: error)
          @currentErrors.push(errorView)
          $('#root').append errorView.render().$el
        $('.error-message h5').fadeIn('slow')

  _updateUser: ->
    formData = $('.edit-user-info').serializeJSON()
    @model.save(formData)

