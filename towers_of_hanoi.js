var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var HanoiGame = function () {
  this.stacks = [[3,2,1], [], []];
};

HanoiGame.prototype.isWon = function () {
  for (var i = 0; i < 3; i++) {
    var stack = this.stacks[2];
    console.log(stack);
    if (stack.length === 0 || stack[i] !== 3 - i ) {
      return false;
    }
  }
  return true;
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  var startTower = this.stacks[startTowerIdx];
  var endTower = this.stacks[endTowerIdx];
  if (endTower.length === 0 ||startTower.slice(-1)[0] < endTower.slice(-1)[0]) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  var startTower = this.stacks[startTowerIdx];
  var endTower = this.stacks[endTowerIdx];
  if (this.isValidMove(startTowerIdx, endTowerIdx) ) {
    endTower.push(startTower.pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function () {
  for (var i = 0; i < this.stacks.length; i++) {
    var stack = this.stacks[i];
    console.log(JSON.stringify(stack) + '\n');
  }
};

// if (parsedChoice >= 0 && parsedChoice <= 2)

HanoiGame.prototype.promptMove = function(callback) {
  var that = this;
  this.print();

  function firstTowerIdxFinder () {
    reader.question("Start tower index?\n", function (answer) {
      lastTowerIdxFinder(parseInt(answer));
    });
  }

  function lastTowerIdxFinder(startTowerIdx) {
    reader.question("End tower index?\n", function (answer) {
      var endTowerIdx = parseInt(answer);
      if (inRange(startTowerIdx) && inRange(endTowerIdx)) {
        finalCheck(startTowerIdx, endTowerIdx);
      } else {
        console.log("indices not in range");
        firstTowerIdxFinder();
      }
    });
  }

  function inRange(index) {
    if (index >= 0 && index <= 2) {
      return true;
    } else {
      return false;
    }
  }

  function finalCheck (startTowerIdx, endTowerIdx) {
    if (inRange(startTowerIdx) && inRange(endTowerIdx)) {
      callback(startTowerIdx, endTowerIdx);
    } else {
      that.firstTowerIdxfinder(callback);
    }
  }

  firstTowerIdxFinder();
};

HanoiGame.prototype.run = function(completionCallback) {
  var that = this;
  that.promptMove(function(startTowerIdx, endTowerIdx) {
    if (that.move(startTowerIdx, endTowerIdx)) {
      if (that.isWon()) {
        console.log("You Win!");
        completionCallback();
      } else {
        that.run(completionCallback);
      }
    } else {
      console.log("Invalid Move!");
      that.run(completionCallback);
    }
  });
};

var game = new HanoiGame();
game.run(function () {
  reader.close();
});
