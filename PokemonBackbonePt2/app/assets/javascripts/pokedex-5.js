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

  refreshPokemon: function (callback, options) {

    this.collection.fetch({
      success: callback
    });
  },

  render: function () {
    this.$el.empty();
    var that = this;
    this.collection.each( function(pokemon) {
      that.addPokemonToList(pokemon);
    });
  },

  selectPokemonFromList: function (event) {
    var poke = this.collection.get($(event.currentTarget).data('id'))
    Backbone.history.navigate('/pokemon/' + poke.id, { trigger: true });
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toy-list-item": "selectToyFromList"
  },

  refreshPokemon: function (callback, options) {
    var that = this;
    this.model.fetch( {
      success: that.render.bind(this, callback)
    });

    return this;
  },

  render: function (callback) {

    var content = JST['pokemonDetail']({pokemon: this.model});
    var $ul = $('<ul>');
    this.model.toys().each( function(toy) {
      var x = JST['toyListItem']({toy: toy});
      $ul.append(x);
    });
    this.$el.html(content);
    this.$el.append($ul);
    callback();
  },

  selectToyFromList: function (event) {
    var $target = $(event.currentTarget);
    Backbone.history.navigate(
      'pokemon/' +
      $target.data('pokemon-id') +
      '/toys/' + $target.data('id'),
      {trigger: true}
    );

  }
});

window.Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.append(JST['toyDetail']({pokes: [], toy: this.model}));
  }
});
