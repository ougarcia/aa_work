NewsReader.Routers.Feeds = Backbone.Router.extend({

  routes: {
    "": "feedsIndex"
  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  feedsIndex: function() {
    this.feedsCollection = new NewsReader.Collections.Feeds();
    var feedsIndexView = new NewsReader.Views.FeedsIndex({
      collection: this.feedsCollection
    });
    feedsIndexView.collection.fetch();
    this.$rootEl.html(feedsIndexView.render().$el);
    // feedsIndexView.render().$el.appendTo(this.$rootEl);
  }

});
