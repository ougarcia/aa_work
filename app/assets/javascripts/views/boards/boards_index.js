window.TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({
  template: JST['boards/index'],

  initialize: function() {
    this.listenTo(this.collection, 'add', this.addBoardView);
    this.collection.each(this.addBoardView.bind(this));
  },

  addBoardView: function (board) {
    var subview = new window.TrelloClone.Views.BoardItem({ model: board });
    this.addSubview('.boards-index-list', subview);
  },

  render: function () {
    var content = this.template();
    console.log(content);
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
