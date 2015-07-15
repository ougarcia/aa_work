$.Carousel = function (el) {
  this.$el = $(el);
  this.$activeIdx = 0;
  this.setActiveItem();
  this.setClickHandlers();
  this.transitioning = false;
};

$.Carousel.prototype.setClickHandlers = function () {

  $('.slide-left').on('click', function (event) {
    if (this.transitioning) {
      return null;
    }
    this.transitioning = true;
    $('.items img').eq(this.$activeIdx).removeClass('active').addClass('left');
    $('.items img').removeClass('left');
    $('.items img').removeClass('right');
    this.slide(-1);
  }.bind(this));

  $('.slide-right').on('click', function (event) {
    if (this.transitioning) {
      return null;
    }
    this.transitioning = true;
    $('.items > img').eq(this.$activeIdx).removeClass('active').addClass('right');
    $('.items img').removeClass('left');
    $('.items img').removeClass('right');
    this.slide(1);
  }.bind(this));
};

$.Carousel.prototype.setActiveItem = function () {
  var $activeItem = $('.items > *').eq(this.$activeIdx);
  $activeItem.addClass('active');
  $activeItem.one('transitionend', function (event) {
    this.transitioning = false;
  }.bind(this));

  var leftIdx = this.fixIdx(this.$activeIdx - 1);
  var rightIdx = this.fixIdx(this.$activeIdx + 1);
  $('.items > *').eq(leftIdx).addClass('left');
  $('.items > *').eq(rightIdx).addClass('right');
};


$.Carousel.prototype.slide = function(dir) {
  this.$activeIdx += dir;
  this.$activeIdx = this.fixIdx(this.$activeIdx);
  this.setActiveItem();
};

$.Carousel.prototype.fixIdx = function (idx) {
  var itemsLastIdx = $('.items img').size();
  if (idx < 0) {
    return itemsLastIdx + idx;
  } else {
    return idx % (itemsLastIdx);
  }
};


$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
