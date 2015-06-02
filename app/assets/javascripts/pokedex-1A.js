Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $('<li>').text(pokemon.escape('name'));
  $li.append(' ');
  $li.append(pokemon.escape('poke_type')).addClass('poke-list-item');
  $li.attr('data-id', pokemon.id);
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var that = this;
  this.pokes.fetch({
    success: function(collection, response) {
      _.each(collection.models, function(poke) {
        that.addPokemonToList(poke);
      });
    }
  });
};
