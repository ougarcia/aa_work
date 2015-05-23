function Knight () {
  this.name = "knighty";
};

Knight.prototype.sayName = function() {
  console.log(this.name);
}

module.exports = Knight;

var k = new Knight;
k.sayName();
