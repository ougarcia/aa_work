NewsReader.Views.FeedsIndex = Backbone.CompositeView.extend({
  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, 'add', this.addFeedView);
    this.collection.each(this.addFeedView.bind(this));
    this.listenTo(this.collection, 'remove', this.removeFeedView);
  },

  addFeedView: function (feed) {
    var subView = new NewsReader.Views.FeedItem({ model: feed });
    // method inherited from CompositeView
    this.addSubview('ul.feeds', subView);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  removeFeedView: function(feed) {
    this.removeModelSubview('ul.feeds', feed);
  },


});
