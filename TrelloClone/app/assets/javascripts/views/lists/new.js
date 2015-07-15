TrelloClone.Views.NewList = Backbone.View.extend({
  className: "col-md-3",
  template: JST['lists/new'],

  events: {
    'submit .new-list-form': 'handleSubmit'
  },
  
  initialize: function(options) {
    this.board = options.board;
    this.lists = options.lists;
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
        that.lists.add(newList);
      }
    });

    this.render();
  }
});
