TrelloClone.Collections.Cards = Backbone.Collection.extend({
  model: TrelloClone.Models.Card,

  initialize: function (options) {
    this.list = options.list;
  },

  comparator: function(collection) {
    return collection.get('ord');
  },


  reorder: function(arr) {
    for (var i = 0; i < arr.length; i++) {
      var id = arr[i];
      var card = this.get(id);
      card.set({ord: i});
      card.save();
    }
    console.log('reordering cards');
  }

});
