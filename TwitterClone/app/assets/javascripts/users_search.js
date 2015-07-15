$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$ul = this.$el.find("ul");

  this.$input.on("input", this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (event) {
  var val = this.$input.val();
  $.ajax({
    type: "GET",
    data: "query=" + val,
    dataType: "json",
    url: "/users/search",
    success: this.renderResults.bind(this)
  });
};

$.UsersSearch.prototype.renderResults = function (response) {
  this.$ul.empty();
  console.log(response);
  for (var i = 0; i < response.length; i++) {
    var user = response[i];
    var followText = (user.followed) ? "followed" : "unfollowed";
    var anchor = $('<a>').attr('href', '/users/'+user.id).text(user.username);
    var button = $('<button>').attr({
      "class": 'follow-toggle',
      "data-user-id": ""+user.id,
      "data-initial-follow-state": followText
    });
    this.$ul.append( $('<li>').append(anchor).append(button) );
  }
  $("button.follow-toggle").followToggle();
};

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $("div.users-search").usersSearch();
});
