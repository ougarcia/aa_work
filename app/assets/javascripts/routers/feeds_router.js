NewsReader.Routers.Feeds = Backbone.Router.extend({

  routes: {
    "": "feedsIndex",
    "feeds/:feedId": "entriesIndex"

  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.feedsCollection = new NewsReader.Collections.Feeds();
  },

  entriesIndex: function(feedId) {

    var feed = this.feedsCollection.getOrFetch(feedId);
    var entriesCollection = feed.entries();
    entriesCollection.fetch();
    var entriesIndexView = new NewsReader.Views.EntriesIndex({
      collection: entriesCollection
    });

    this.$rootEl.html(entriesIndexView.render().$el);
  },

  feedsIndex: function() {
    var feedsIndexView = new NewsReader.Views.FeedsIndex({
      collection: this.feedsCollection
    });
    feedsIndexView.collection.fetch();
    this.$rootEl.html(feedsIndexView.render().$el);
    // feedsIndexView.render().$el.appendTo(this.$rootEl);
  }

});
