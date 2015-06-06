TrelloClone.Views.NewList = Backbone.View.extend({
  template: JST['lists/new'],

  events: {
    'submit .new-list-form': 'handleSubmit'
  },
  
  initialize: function(options) {
    this.board = options.board;
    this.boardView = options.boardView;
    this.collection = options.collection;
    debugger;
  },
  
  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },


  handleSubmit: function (event) {
    var that = this;
    event.preventDefault();
    var $target = $(event.currentTarget).serializeJSON();
    $target['list']['board_id'] = this.board.id;
    var newList = new TrelloClone.Models.List();
    newList.save($target.list, {
      success: function () {
        console.log('successfully added list');
        that.board.collection.add(newList, {trigger: true} );
        that.board.fetch(); // for sme reason add doesn't trigger the add listener
      }
    });
    // remove self from DOM
    // maybe do other stuff
  }

});
