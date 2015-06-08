TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST['boards/show'],
  //boardshow IS the listIndex

  initialize: function () {
    this.collection = this.model.lists();
    this.collection.each(this.addListView.bind(this));
    this.setListeners();
    this.setForm();
   },

  setListeners: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addListView);
    this.listenTo(this.collection, 'remove', this.removeListView);
  },

  setForm: function () {
    this._form && this._form.remove();
    this._form = new TrelloClone.Views.NewList({
      board: this.model,
      lists: this.collection
    });
    this.addSubview('.lists', this._form, true);
  },

  addListView: function(list) {
    var subview = new TrelloClone.Views.ListShow({ model: list });
    this.addSubview('.lists', subview);
  },

  removeListView: function(list) {
    this.removeModelSubview('.lists', list);
  },

  render: function() {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }

});
