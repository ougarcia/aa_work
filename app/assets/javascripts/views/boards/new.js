TrelloClone.Views.newBoard = Backbone.View.extend({
  template: JST['boards/new'],

  events: {
    'submit .board-form': 'handleSubmit'
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  handleSubmit: function (event) {
    event.preventDefault();
    var $target = $(event.currentTarget).serializeJSON();
    var newBoard = new TrelloClone.Models.Board();
    newBoard.set($target.board);
    newBoard.save({}, {
      wait: true,
      success: function() {
        Backbone.history.navigate( 'boards/' + newBoard.id, {trigger: true})
      }
    });
  }

});
