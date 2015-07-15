var Board = function () {
  this.grid = [[], [], []];
};

function isHorizontalWin (grid) {
  for(var i = 0; i < grid.length; i++) {
    if (isWinningArray(grid[i])) {
      return true;
    }
  }
  return false;
}

function isWinningArray (arr) {
  if (arr.length === 0) {
    return false;
  }
  var markType = arr[0];

  for (var i = 0; i < 3; i++) {
    if (markType === undefined || markType !== arr[i]) {
      return false;
    }
  }
  return true;
}


function isVerticalWin (grid) {
  var result = [[], [], []];
  for (var i = 0; i < grid.length; i++) {
    for (var j = 0; j < grid.length; j++) {
      if (grid[j][i] === undefined) {
        result[i][j] = "v";
      } else {
      result[i][j] = grid[j][i];
      }
    }

  return isHorizontalWin(result);
  }
}

function isDiagonalWin (grid) {
  var result = [[], []];
  for (var i = 0; i < grid.length; i++) {
    result[0].push(grid[i][i]);
    result[1].push(grid[i][2 -i]);
  }
  return isHorizontalWin(result);
}

Board.prototype.isWon = function () {
  return isDiagonalWin(this.grid) || isVerticalWin(this.grid) || isWinningArray(this.grid);
};


Board.prototype.isEmpty = function (position) {
  this.pos(position[0], position[1]) === undefined;
};

Board.prototype.pos = function (x, y) {
  return this.grid[x][y];
};

Board.prototype.placeMark = function(position, mark) {
  this.grid[position[0]][position[1]] = mark;
};


function seperator () {
  return "-+-+-";
}

function makeRowPretty (row) {
  var result = [];
  for (var i = 0; i < 3; i++) {
    if (row[i] === undefined) {
    result.push(" ");
    } else {
    result.push(row[i]);
    }
  }
  return result.join("|");
}


Board.prototype.print = function () {
  console.log("\n");
  for (var i = 0; i< this.grid.length; i++) {
    console.log(makeRowPretty(this.grid[i]));
    if (i !== 2) {
      console.log(seperator());
    }
  }
};


module.exports = Board;
