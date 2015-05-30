$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.data('user-id');
  this.followState = this.$el.data('initial-follow-state');
  this.$el.on("click", this.handleClick.bind(this));
  this.render();
};

$.FollowToggle.prototype.render = function () {
  var buttonText = (this.followState === "followed") ? "Unfollow" : "Follow";
  this.$el.text(buttonText);
  this.$el.prop('disabled', false);
};

$.FollowToggle.prototype.success = function () {
  if (this.followState === "following") {
    this.followState = "followed";
  } else if (this.followState === "unfollowing") {
    this.followState = "unfollowed";
  }
  this.render();
};


$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();
  this.$el.prop('disabled', true);
  var that = this;
  if (this.followState === "followed") {
    this.followState = "unfollowing";

    $.ajax({
        url: "/users/" + this.userId + "/follow",
        type: "DELETE",
        dataType: "json",
        success: this.success.bind(this)
    });
  } else if (this.followState === "unfollowed") {
    this.followState = "following";
    $.ajax({
        url: "/users/" + this.userId + "/follow",
        type: "POST",
        dataType: "json",
        success: this.success.bind(this)
    });
  }

};

$.fn.followToggle = function () {
  return this.each(function () {
    new $.FollowToggle(this);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
