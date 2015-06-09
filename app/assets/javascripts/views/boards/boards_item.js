TrelloClone.Views.BoardItem = Backbone.View.extend({
  template: JST['boards/item'],
  tagName: 'li',
  className: 'boards-index-item',

  events: {
    'click .delete-board': 'deleteBoard'
  },
  initialize: function () {
  },


  deleteBoard: function() {
    this.model.destroy();
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  }
});
