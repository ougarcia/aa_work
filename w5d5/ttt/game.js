var Game = function (reader, board) {
  this.reader = reader;
  this.board = board;
};

Game.prototype.run = function (turn, completionCallback) {
  var that = this;

  this.board.print();
  this.reader.question("What's your move?", function(answer) {
    var moveChoice = answer.split('');
    for (var i = 0; i < moveChoice.length; i++) {
      moveChoice[i] = parseInt(moveChoice[i]);
    }
    that.board.placeMark(moveChoice, turn);
    if (that.board.isWon()) {
      completionCallback(turn);
    } else {
      if (turn === "o") {
        turn = "x";
      } else {
        turn = "o";
      }
      that.run(turn, completionCallback);
    }
  });
};

module.exports = Game;
