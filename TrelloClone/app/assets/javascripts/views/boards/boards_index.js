window.TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({
  template: JST['boards/index'],

  initialize: function() {
    this.listenTo(this.collection, 'add', this.addBoardView);
    this.listenTo(this.collection, 'remove', this.removeBoardView);
    this.listenTo(this.collection, 'sync', this.render);
    this.collection.each(this.addBoardView.bind(this));
  },

  addBoardView: function (board) {
    var subview = new window.TrelloClone.Views.BoardItem({ model: board });
    this.addSubview('.boards-index-list', subview);
  },

  removeBoardView: function (board) {
    this.removeModelSubview('.boards-index-list', board);
  },

  render: function () {
    console.log('rendering index');
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
