// make a uniq

Array.prototype.uniq = function () {
  var arr2 = [];
  for ( var i = 0; i < this.length; i++) {
    if ( arr2.indexOf(this[i]) === -1) {
      arr2.push(this[i]);
    }
  }

  return arr2;
};

// console.log([1, 1, 2, 2, 3, 4, 5, 3, 5, 2].uniq());


Array.prototype.twoSum = function () {
  var result = [];
  for (var i = 0; i < this.length - 1; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if ( this[i] + this[j] === 0) {
        result.push([i, j]);
      }
    }
  }
  return result;
};

// console.log([-1, 0, 1, 0, 2, 3, -2].twoSum());


Array.prototype.transpose = function () {
  var result = [];
  for (var i = 0; i < this.length; i++) {
    result.push([]);
    for (var j = 0; j < this.length; j++) {
      result[i][j] = this[j][i];
    }
  }

  return result;
};


//console.log([[0, 1, 2],
//            [3, 4, 5],
//            [6, 7, 8]].transpose());

Array.prototype.myEach = function(f){
  var i = 0;
  while (i < this.length){
    f(this[i]);
    i++;
  }
  return this;
};

// console.log([1,2,3].myEach(function(x){console.log(x);}));

Array.prototype.myMap = function (f) {
  var result = [];
  this.myEach(function (el) {
    result.push(f(el));
  });
  return result;
};

// console.log([1, 2, 3].myMap(function(x) { return x * 2 ;}));

Array.prototype.myInject = function (f) {
  var accumulator = this[0];
  this.slice(1).myEach(function (el) {
    accumulator = f(accumulator, el);
  });

  return accumulator;
};


console.log([1, 2, 3].myInject ( function(accumulator, el) { return accumulator + el ;} ));
