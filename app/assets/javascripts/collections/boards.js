window.TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: 'api/boards',
  model: window.TrelloClone.Models.Board
});
