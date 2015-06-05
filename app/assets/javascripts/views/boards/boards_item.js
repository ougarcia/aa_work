TrelloClone.Views.BoardItem = Backbone.View.extend({
  template: JST['boards/item'],
  tagName: 'li',
  className: 'boards-index-item',

  initialize: function () {
  },

  render: function () {
    var content = this.model.get('title');
    this.$el.text(content);
    return this;
  }
});
