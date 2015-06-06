TrelloClone.Views.ListShow = Backbone.View.extend({
  template: JST['lists/show'],

  // eventually change to CompositeView

  intialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    // this.collection = this.model.cards
  },
  
  render: function() {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    // this.attachSubviews();
    return this;
  }
});
