window.TrelloClone.Routers.main = Backbone.Router.extend({

  routes: {
  '': 'boardsIndex'
  },

  initialize: function () {
    this.$rootEl = $('#main');
    console.log('initializes router');
  },

  boardsIndex: function() {
    var boards = new TrelloClone.Collections.Boards();
    var boardsIndexView = new window.TrelloClone.Views.BoardsIndex({
      collection: boards
    });
    this.$rootEl.html(boardsIndexView.render().$el);
    boards.fetch({
      success: boardsIndexView.render.bind(boardsIndexView)
    });
  }



});
