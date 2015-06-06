TrelloClone.Collections.Lists = Backbone.Collection.extend({
  url: 'api/boards/:boardId/lists',

  comparator: 'ord'

});
