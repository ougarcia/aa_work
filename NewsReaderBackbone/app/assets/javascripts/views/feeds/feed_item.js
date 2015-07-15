NewsReader.Views.FeedItem = Backbone.View.extend({
  template: JST['feeds/index_list_item'],

  events: {
    "click li": "redirectToItem"
  },


  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  },

  redirectToItem: function (event) {
    event.preventDefault();
    Backbone.history.navigate('feeds/' + this.model.id);
  }


});
