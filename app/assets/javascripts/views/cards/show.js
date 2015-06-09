TrelloClone.Views.CardShow = Backbone.CompositeView.extend({
  template: JST['cards/show'],
  className: 'card',

  initialize: function () {
    this.collection = this.model.items();
    this.setListeners();
  },

  setListeners: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addItemView);
    this.listenTo(this.collection, 'remove', this.removeitemView);
    this.collection.each(this.addItemView.bind(this));
  },

  addItemView: function(item) {
    var subview = new TrelloClone.Views.ItemShow({ model: item });
    this.addSubview('.items', subview);
  },

  removeItemView: function(item) {
    this.removeModelSubview('.items', item);
  },

  render: function() {
    var content = this.template({ card: this.model });
    this.$el.attr('data-id', this.model.id);
    this.$el.html(content);
    this.attachSubviews();
    return this;
  }

});
