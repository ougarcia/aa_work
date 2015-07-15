window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.router = new TrelloClone.Routers.main();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
