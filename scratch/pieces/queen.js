function Queen () {
  this.name = "queeen";
}

Queen.prototype.sayName = function () {
  console.log(this.name);
};

module.exports = Queen;
