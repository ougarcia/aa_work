function Pawn () {
  this.name = "pawn";
}


Pawn.prototype.sayName = function () {
  console.log(this.name);
};

module.exports = Pawn;
var p = new Pawn();
p.sayName();


