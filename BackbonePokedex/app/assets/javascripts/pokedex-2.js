window.Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = $('<li>').attr('data-id', toy.id);
  $li.attr('data-pokemon_id', toy.attributes.pokemon_id);
  $li.text([toy.attributes.name, toy.attributes.happiness, toy.attributes.price].join(' '));
  $('ul.toys').append($li);
};

window.Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var divDetail = $("<div>").addClass("detail").html(addImage(toy));
  this.$toyDetail.html(divDetail);
};

function addImage(toy) {
  return $('<img>').attr('src', toy.attributes.image_url);
}

window.Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var target = $(event.currentTarget);
  var pokeId = target.data('pokemon_id');
  var toyId = target.data('id');
  var toy = this.pokes.get(pokeId).toys().get(toyId);
  this.renderToyDetail(toy);
};
