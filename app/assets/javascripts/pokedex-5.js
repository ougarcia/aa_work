Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {

    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", function (model) {
      this.collection.add(model);
      this.addPokemonToList(model);
    });
  },

  addPokemonToList: function (pokemon) {
    var content = JST['pokemonListItem']({pokemon: pokemon});

    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    this.collection.fetch();
  },

  render: function () {
    console.log("thisthinghere");
    this.$el.empty();
    var that = this;
    this.collection.each( function(pokemon) {
      that.addPokemonToList(pokemon);
    });
  },

  selectPokemonFromList: function (event) {
    var poke = this.collection.get($(event.currentTarget).data('id'))
    var $pokeDetailView = new Pokedex.Views.PokemonDetail({
      model: poke
    });
    $("#pokedex .pokemon-detail").html($pokeDetailView.$el);
    $pokeDetailView.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toy-list-item": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    var that = this;
    this.model.fetch( {
      success: that.render.bind(this)
    });
  },

  render: function () {

    var content = JST['pokemonDetail']({pokemon: this.model});
    var $ul = $('<ul>');
    this.model.toys().each( function(toy) {
      var x = JST['toyListItem']({toy: toy});
      console.log("hey");
      $ul.append(x);
    });
    this.$el.html(content);
    this.$el.append($ul);
  },

  selectToyFromList: function (event) {
    var ourModel = this.model.toys().get($(event.currentTarget).data('id'));
    var toyView = new window.Pokedex.Views.ToyDetail({
      model: ourModel
    });
    $('#pokedex .toy-detail').html(toyView.$el);
    toyView.render();
  }
});

window.Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.append(JST['toyDetail']({pokes: [], toy: this.model}));
  }
});


$(function () {
  var pokemons = new window.Pokedex.Collections.Pokemon();
  pokemons.fetch();
  var pokemonIndex = new window.Pokedex.Views.PokemonIndex({
    collection: pokemons
  });
  // pokemonIndex.collection.fetch();
  // pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
