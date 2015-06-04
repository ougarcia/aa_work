NewsReader.Views.FeedItem = Backbone.View.extend({
  template: JST['feeds/index_list_item'],

  // 
  // events: {
  //
  // },
  //
  // initialize: function() {
  //
  // },


  render: function () {
    console.log('subview being rendered');
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    return this;
  }


});
