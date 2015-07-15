TrelloClone.Collections.Lists = Backbone.Collection.extend({
  model: TrelloClone.Models.List,


  comparator: function (collection) {
    return collection.get('ord');
  },


  reorder: function(arr) {
    for (var i = 0; i < arr.length; i++) {
      var id = arr[i];
      var list = this.get(id);
      list.set({ord: i});
      list.save();
    }
    console.log('reordering lists');
  }
});
