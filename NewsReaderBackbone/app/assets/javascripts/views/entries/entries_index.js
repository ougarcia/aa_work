NewsReader.Views.EntriesIndex = Backbone.CompositeView.extend({

  template: JST['entries/index'],

  initialize: function () {
    this.listenTo(this.collection, 'add', this.addEntryView);
    this.collection.each(this.addEntryView.bind(this));
    this.listenTo(this.collection, 'remove', this.removeEntryView);
  },

  addEntryView: function (model) {
    var subView = new NewsReader.Views.EntryListItem({ model: model });
    // method inherited from CompositeView
    this.addSubview('ul.entry-list', subView);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  removeEntryView: function(model) {
    this.removeModelSubview('ul.entry-list', model);
  },



});
