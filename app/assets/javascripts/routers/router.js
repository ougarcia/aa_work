window.TrelloClone.Routers.main = Backbone.Router.extend({

  routes: {
  '': 'boardsIndex',
  'new': 'newBoard',
  'boards/:id': 'showBoard'
  },

  initialize: function () {
    this.$rootEl = $('#main');
    this.boards = new TrelloClone.Collections.Boards();
  },

  boardsIndex: function() {
    var boardsIndexView = new window.TrelloClone.Views.BoardsIndex({
      collection: this.boards
    });
    this.$rootEl.html(boardsIndexView.render().$el);
    this.boards.fetch();
  },

  newBoard: function() {
    var newBoardView = new TrelloClone.Views.newBoard();
    this.$rootEl.html(newBoardView.render().$el);
  },

  showBoard: function (id) {
    var board = this.boards.getOrFetch(id);
    var showBoardView = new TrelloClone.Views.BoardShow({ model: board });
    this.$rootEl.html(showBoardView.render().$el);
  }
});
