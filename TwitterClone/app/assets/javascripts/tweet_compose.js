$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$feed = $(this.$el.data('tweets-ul'));
  this.$charCount = 140;
  $('.chars-left', this.$el).text(this.$charCount);
  this.$el.on("submit", this.submit.bind(this));
  $('textarea', this.$el).on("input", this.charCount.bind(this));
};

$.TweetCompose.prototype.charCount = function (event) {
  this.$charCount = 140 - $('textarea', this.$el).val().length;
  $('.chars-left', this.$el).text(this.$charCount);
};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();
  var formData = this.$el.serializeJSON();
  $(":input", this.$el).prop("disabled", true);
  $.ajax({
    data: formData,
    dataType: "json",
    type: "POST",
    url: "/tweets",
    success: this.handleSuccess.bind(this)
  });
};

$.TweetCompose.prototype.handleSuccess = function (response) {
  var tweet = $('<li>').text(JSON.stringify(response));
  this.$feed.prepend(tweet);
  this.clearInput();
  $(":input", this.$el).prop("disabled", false);
};

$.TweetCompose.prototype.clearInput = function (event) {
  $('.clearable', this.$el).val("");
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $("form.tweet-compose").tweetCompose();
});
