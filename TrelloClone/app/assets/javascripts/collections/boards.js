window.TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: 'api/boards',
  model: window.TrelloClone.Models.Board,


  getOrFetch: function (id) {
    var that = this;
    var board;
    if (!(board = this.get(id))) {
      board = new TrelloClone.Models.Board({ id: id });
      board.fetch({
        success: function () { that.add(board, { merge: true}); }
      });
    } else {
      board.fetch();
    }

    return board;
  }
});
