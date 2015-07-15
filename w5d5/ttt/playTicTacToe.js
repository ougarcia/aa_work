var t3 = require("../ttt");

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var board = new t3.Board();
var game = new t3.Game(reader, board);
game.run("x", function(winner) {
  console.log(winner + " wins!");
  reader.close();
});
