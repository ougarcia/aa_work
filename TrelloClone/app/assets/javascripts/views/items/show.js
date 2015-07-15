TrelloClone.Views.ItemShow = Backbone.View.extend({
  tagName: 'li',

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    this.$el.html(this.model.get('title'));
    return this;
  }
});
