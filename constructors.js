function Cat(name,owner){
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function(){
  console.log("Everyone loves " + this.name + "!");
};

Cat.prototype.meow = function(){
  console.log("Meow!");
};

var cat1 = new Cat("Tabby","Tabitha");
var cat2 = new Cat("Octocat","Github");
var cat3 = new Cat("Snoo","Reddit");
var cat4 = new Cat("Thomas O' Malley","Nobody");
cat4.meow();
cat4.meow = function(){
  console.log("Me-OWWW!");
};
cat4.meow();
