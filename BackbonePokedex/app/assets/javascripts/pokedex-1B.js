window.Pokedex.RootView.prototype.prettifyAttributes = function (attrs) {
  var list = $('<ul>');
  _.each(attrs, function(el) {
    list.append($('<li>').text(el));
  });
  return list;
};

window.Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $detailDiv = $('<div>').addClass('detail');
  $detailDiv.append($('<img>').attr('src', pokemon.get('image_url')));
  $detailDiv.append($('<span>').append(this.prettifyAttributes(pokemon.attributes)));

  this.$pokeDetail.html($detailDiv);
  var $ulToys = $('<ul>').addClass('toys');
  $ulToys.appendTo(this.$pokeDetail);
  pokemon.fetch({
    success: function() {
      $('ul.toys').on('click', 'li', this.selectToyFromList.bind(this));
      pokemon.toys().each( function(el) {

        this.addToyToList(el);
      }.bind(this));
  }.bind(this)});
};

window.Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
    var pokemonId = $(event.currentTarget).data('id');
    this.renderPokemonDetail(this.pokes.get(pokemonId));
};
