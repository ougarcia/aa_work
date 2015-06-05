NewsReader.Views.FeedItem = Backbone.View.extend({
  template: JST['feeds/index_list_item'],

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  }


});
