
Array.prototype.bubbleSort = function() {
  var arr = this.slice(0);
  var sorted = false;
  while (sorted === false) {
    sorted = true;
    for (var i = 0; i < arr.length - 1; i++) {
      if (arr[i] > arr[i+1]) {
        var buffer = arr[i+1];
        arr[i+1] = arr[i];
        arr[i] = buffer;
        sorted = false;
      }
    }
  }
  return arr;
};



String.prototype.subString = function() {
  var result = [];
  for (var i = 0; i < this.length; i++){
    for (var j = i; j < this.length; j++){
      result.push(this.slice(i, j+1 ));
    }
  }
  return result;
};


console.log([1, 9, 2, 8, 3, 7, 4, 6, 5].bubbleSort());

//console.log("abxyz".subString()  );
