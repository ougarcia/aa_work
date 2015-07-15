TrelloClone.Views.ListShow = Backbone.CompositeView.extend({
  className: "col-md-2 listIndex",
  template: JST['lists/show'],


  initialize: function (options) {
    this.board = options.boardView;
    this.collection = this.model.cards();
    this.collection.each(this.addCardView.bind(this));
    this.setListeners();
  },

  setListeners: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addCardView);
    this.listenTo(this.collection, 'remove', this.removeCardView);
  },

  addCardView: function (card) {
    var subview = new TrelloClone.Views.CardShow({ model: card });
    this.addSubview('.cards', subview);
  },

  removeCardView: function(card) {
    this.removeModelSubview('.cards', card);
  },
 
  handleCardChange: function(event, ui) {
    var cards = this.$el.find('.cards > .card');
    var newOrder = cards.map( function(i, el) {
      return $(el).data('id');
    });
    this.board.reorderCards();
    //use composite view method to find subviews I want
    var ListViews = this.subviews('listIndex');
    debugger;
    var oldList = this.collection.list;
    var newListId = ui.item.parents('.listIndex').data('id');
    var newList = this.model.collection.get(newListId);
    if (oldList.id === newList.id) {
      this.collection.reorder(newOrder);
    } else {
      oldList.reorderCards();
      newList.reorderCards();
    }
  },

  reorderCards: function () {
    var cards = this.$el.find('.cards > .card');
    var newOrder = cards.map( function(i, el) {
      return $(el).data('id');
    });
      this.collection.reorder(newOrder);
  },


  render: function() {
    var that = this;
    this.$el.attr('data-id', this.model.id);
    var content = this.template({ list: this.model });
    this.$el.html(content);

    setTimeout( function () {
      that.$('.cards').sortable({
        update: that.handleCardChange.bind(that),
        connectWith: '.cards'
      });
    }, 0);

    this.attachSubviews();
    return this;
  }
});
