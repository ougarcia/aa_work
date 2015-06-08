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
    var view = new TrelloClone.Views.BoardsIndex({
      collection: this.boards
    });
    this._swapView(view);
    this.boards.fetch();
  },

  newBoard: function() {
    var newBoardView = new TrelloClone.Views.newBoard();
    this.$rootEl.html(newBoardView.render().$el);
  },

  showBoard: function (id) {
    var board = this.boards.getOrFetch(id);
    var view = new TrelloClone.Views.BoardShow({ model: board });
    this._swapView(view);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
