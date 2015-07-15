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
    this.addSubview('.new-list', this._form, true);
  },

  addListView: function(list) {
    var subview = new TrelloClone.Views.ListShow({ model: list, boardView: this });
    this.addSubview('.lists', subview);
  },

  removeListView: function(list) {
    this.removeModelSubview('.lists', list);
  },
  
  handleListChange: function (event, ui) {
    var lists = $('.lists > .listIndex');
    var newOrder = lists.map( function(i, el) {
      return $(el).data('id');
    });
    this.collection.reorder(newOrder);
  },

  reorderCards: function () {
    debugger;
  },

  
  render: function() {
    var content = this.template({ board: this.model });
    var that = this;
    this.$el.html(content);
    $('.lists').sortable({
      update: that.handleListChange.bind(that)
    });
    this.attachSubviews();
      return this;
  }

});
