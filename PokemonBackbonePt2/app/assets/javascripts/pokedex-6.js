Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': 'pokemonDetail',
    'pokemon/:pokemonId/toys/:toyId': 'toyDetail'
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex) {
      var that = this;
      this.pokemonIndex(that.pokemonDetail.bind(that, id, callback));

    } else {
      var x = this._pokemonIndex.collection.get(id);
      this._pokemonDetail = new window.Pokedex.Views.PokemonDetail({
        model: x
      });

      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
      this._pokemonDetail.refreshPokemon(callback);
    }
  },

  pokemonIndex: function (callback) {
    var pokemons = new window.Pokedex.Collections.Pokemon();
    this._pokemonIndex = new window.Pokedex.Views.PokemonIndex({
      collection: pokemons
    });
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this._pokemonIndex.refreshPokemon(callback);
  },

  toyDetail: function (pokemonId, toyId) {
    if (!this._pokemonDetail) {
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
      console.log(1);
    } else {
      console.log(2);
      var ourModel = this._pokemonDetail.model.toys().get(toyId);
      var toyView = new window.Pokedex.Views.ToyDetail({
        model: ourModel
      });
      $('#pokedex .toy-detail').html(toyView.$el);
      toyView.render();
    }
  },

  pokemonForm: function () {
  }
});


$(function () {
  new window.Pokedex.Router();
  Backbone.history.start();
});
