window.TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({
  template: JST['boards/index'],
  tagName: 'ul',
  className: 'boards-index-list',

  initialize: function() {
    console.log("inits boards index view");
    this.listenTo(this.collection, 'add', this.addBoardView);
    this.collection.each(this.addBoardView.bind(this));
  },

  addBoardView: function (board) {
    var subview = new window.BoardView({ model: board });
    this.addSubview('.boards', subview);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }
});
