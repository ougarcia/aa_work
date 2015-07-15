window.Pokedex = (window.Pokedex || {});
window.Pokedex.Models = {};
window.Pokedex.Collections = {};

window.Pokedex.Models.Pokemon = Backbone.Model.extend({
  urlRoot: '/pokemon',
  toys: function() {
    this._toys = this._toys || new window.Pokedex.Collections.PokemonToys([], { pokemon: this });
    return this._toys;
  },

  parse: function(resp, options) {

    if (resp.toys) {
      this.toys().set(resp.toys);
      delete resp.toys;
    }
    return resp;
  }

});

window.Pokedex.Models.Toy = Backbone.Model.extend({

});

window.Pokedex.Collections.Pokemon = Backbone.Collection.extend({
  model: window.Pokedex.Models.Pokemon,
  url: '/pokemon'

});

window.Pokedex.Collections.PokemonToys = Backbone.Collection.extend({
  model: window.Pokedex.Models.Toy
});

window.Pokedex.Test = {
  testShow: function (id) {
    var pokemon = new window.Pokedex.Models.Pokemon({ id: id });
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  },

  testIndex: function () {
    var pokemon = new window.Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  }
};

window.Pokedex.RootView = function ($el) {
  this.$el = $el;
  this.pokes = new window.Pokedex.Collections.Pokemon();
  this.$pokeList = this.$el.find('.pokemon-list');
  this.$pokeDetail = this.$el.find('.pokemon-detail');
  this.$newPoke = this.$el.find('.new-pokemon');
  this.$toyDetail = this.$el.find('.toy-detail');
  this.refreshPokemon();

  this.$pokeList.on('click', 'li', this.selectPokemonFromList.bind(this));
  this.$newPoke.on('submit', this.submitPokemonForm.bind(this));

};

$(function() {
  var $rootEl = $('#pokedex');
	window.Pokedex.rootView = new window.Pokedex.RootView($rootEl);
  window.Pokedex.rootView.refreshPokemon();
});
