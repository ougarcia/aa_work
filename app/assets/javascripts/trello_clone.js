window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    console.log("initializes backbone app");
    this.router = new TrelloClone.Routers.main();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
