$.Thumbnails = function (el) {
  this.$el = el;
  this.$images = $('.gutter-images img');
  this.gutterIdx = 0;
  this.fillGutterImages();
  this.setListeners();
  this.$activeImg = $('.gutter-images img:first-child');
  this.activate(this.$activeImg);
};

$.Thumbnails.prototype.setListeners = function () {
  $('.gutter-images').on('click', 'img', function (event) {
    var $currentTarget = $(event.currentTarget);
    this.$activeImg = $currentTarget;
    this.activate($currentTarget);
  }.bind(this));
};

$.Thumbnails.prototype.fillGutterImages = function () {
  $('.gutter-images').empty();
  for (var i = 0; i < 5; i++){
    var newEl = this.$images.eq(this.gutterIdx);
    $('.gutter-images').append(newEl);
    this.gutterIdx += 1;
  }
};

$.Thumbnails.prototype.activate = function ($img) {
  $('.active').html($img.clone());
};


$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
