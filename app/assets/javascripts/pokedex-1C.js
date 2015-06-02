Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPokemon = new window.Pokedex.Models.Pokemon();
  newPokemon.set(attrs).save({}, {
    success: function() {
      this.addPokemonToList(newPokemon);
      this.pokes.fetch();
      callback(newPokemon);
    }.bind(this)
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var target = $(event.currentTarget).serializeJSON();
  this.createPokemon(target, this.renderPokemonDetail.bind(this));
};
