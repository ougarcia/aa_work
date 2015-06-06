TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST['boards/show'],
  //boardshow IS the listIndex

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.collection = this.model.lists(); // maybe this isn't a backbone collection?
    this.listenTo(this.collection, 'add', this.addListView);
    var form = new TrelloClone.Views.NewList({
      board: this.model,
      boardView: this,
      collection: this.collection
    });
    this.addSubview('.lists', form);
    // this.collection.each(this.addListView.bind(this));
  },

  addListView: function(list) {
    console.log('adding list view');
    var subview = new TrelloClone.Views.ListShow({ model: list });
    this.addSubview('.lists', subview);
  },

  render: function() {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }

});
