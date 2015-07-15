function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  console.log(this.timeNow.getHours() + ":" + this.timeNow.getMinutes() + ":" + this.timeNow.getSeconds());
  setTimeout(this._tick.bind(this), 5000); // Schedule the tick interval
};

Clock.prototype.run = function () {
  this.timeNow = new Date();
  this.printTime();
};

Clock.prototype._tick = function () {
  var newTime = this.timeNow.getSeconds() + 5;
  this.timeNow.setSeconds(newTime);
  this.printTime();
};

var clock = new Clock();
// clock.run();

// add numbers
var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var addNumbers = function(sum, numsLeft, completionCallback) {
  if (numsLeft > 0 ) {
    reader.question("Pick a number", function (answer) {
      var parsedAnswer = parseInt(answer);
      sum += parsedAnswer;
      console.log(sum);
      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  } else {
    completionCallback(sum);
  }
};



function myMethod( arg, myCallback ) {

}

// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
// });

var askIfGreaterThan = function(el1, el2, callback) {
  reader.question(el1 + " > " + el2 + "?", function(answer) {
    if (answer === "yes" ) {
      callback(true);

    } else {
      callback(false);
    }
  });
};

var innerBubbleSortLoop = function(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i + 1], function(isGreaterThan) {
      if (isGreaterThan) {
        var tmp = arr[i+1];
        arr[i+1] = arr[i];
        arr[i] = tmp;
        innerBubbleSortLoop(arr, i+1, true, outerBubbleSortLoop);
      } else {
        innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
      }
    });
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  }
};

var absurdBubbleSort = function(arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    if (madeAnySwaps === true) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
};

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
