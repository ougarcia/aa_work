$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr('data-content-tabs'));
  this.$activeTab = $(this.$contentTabs.find('.active'));
  this.setupClickHandler();
};

$.Tabs.prototype.setupClickHandler = function () {
  // probably switch to something like :
  //  $(ul).on('click', 'a', .....)
  this.$el.on('click', 'a', function(event) {
    this.clickTab(event);
  }.bind(this));
};


$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  $('a').removeClass('active');
  this.$activeTab.removeClass('active').addClass('transitioning');
  var newActiveTab = $($(event.currentTarget).attr('href'));
  this.$activeTab.one('transitionend', function(event) {
    this.$activeTab.removeClass('transitioning');
    this.$activeTab = newActiveTab;
    this.$activeTab.addClass('transitioning').addClass('active');
    setTimeout(function () {
      this.$activeTab.removeClass('transitioning');
    }.bind(this), 0);
  }.bind(this));

  $(event.currentTarget).addClass('active');

};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
