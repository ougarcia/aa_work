var range = function(start, end) {
  if (start > end) {
    return [];
  } else {
    return [start].concat(range(start+1, end));
  }
};

//console.log( range(0, 10) );


var exp1 = function(base, power){
  if (power === 0) {
    return 1;
  }
    return base * exp1(base, power - 1);
};

var exp2 = function(base,power){
  if (power === 0) {
    return 1;
  } else if (power === 1) {
    return base;
  }

  if (power % 2 === 0){
    var val = exp2(base,power/2);
    return val * val;
  }else{
    var val2 = exp2(base, (power-1)/2);
    return base * val2 * val2;
  }
};

var fib = function(n){
  if (n < 1)
    return [];
  if (n === 1)
    return [1];
  if (n === 2){
    return [1,1];
  }
  var prev = fib(n - 1);
  var lastValue = prev[prev.length-1];
  var nextLastValue = prev[prev.length-2];
  var val = lastValue + nextLastValue;
  return prev.concat([val]);
};

var binarySearch = function(arr, target) {
  if ( arr.length === 0 ) {
    return null;
  }
  var pivotIndex = Math.floor(arr.length / 2);
  var pivot = arr[pivotIndex];
  if ( pivot === target ) {
    return pivotIndex;
  } else if ( pivot > target) {
    return binarySearch(arr.slice(0, pivotIndex), target);
  } else if (pivot < target) {
    var result =  binarySearch(arr.slice(pivotIndex+1), target);
    if ( result === null ) {
      return null;
    } else {
    return  pivotIndex + 1 + result;
    }
  }
};


// console.log(binarySearch([1,2,3,4,5,7,8,9], 5))

var makeChange= function(change, coins){
  while (change < coins[0]) { coins = coins.slice(1); }
  var minSolution = [];
  var hasSolution = false;
  if (change > 0) {
    var solution = [];
    var i = 0;
    while (i < coins.length){
      solution = [coins[i]].concat( makeChange(change - coins[i], coins) );
      if (hasSolution === false) {
        minSolution = solution;
        hasSolution = true;
      } else if (solution.length < minSolution.length) {
        minSolution = solution;
      }
      i++;
    }
  }
  return minSolution;
};

var merge = function(arr1, arr2) {
  // takes in two sorted arrays and merges them
  var result = [];
  while (arr1.length > 0 && arr2.length > 0){
    if(arr1[0] < arr2[0]){
      result.push(arr1[0]);
      arr1= arr1.slice(1);
    } else{
      result.push(arr2[0]);
      arr2 = arr2.slice(1);
    }
  }
  result = result.concat(arr1);
  result =  result.concat(arr2);
  return result;

};


var mergeSort = function(arr) {
  if (arr.length <= 1) {
    return arr;
  }

  var pivotIndex = Math.floor(arr.length / 2);
  var left = mergeSort(arr.slice(0, pivotIndex));
  var right = mergeSort(arr.slice(pivotIndex));
  return merge(left, right);
};

var subsets = function(arr){
  if (arr.length === 1) {
    return [arr,[]];
  }
  var r1 = subsets( arr.slice(1) );

  var r2 = [];
  for(var i = 0; i < r1.length; i++){
    r2.push([]);
  }

  for (var i = 0; i < r2.length; i++) {
    for(var j = 0; j < r1[i].length; j++){
      r2[i][j] = r1[i][j];
    }
    r2[i].push(arr[0]);
  }
  return r1.concat(r2);
};


// console.log( subsets([1, 2, 3, 4]) );
// console.log(mergeSort([1,9,2,8,4,20,14]));

// console.log( makeChange(14, [10, 7, 1]) );
//console.log( binarySearch( [0, 1, 2, 3, 4, 5, 6], 4) );




















//console.log(exp1(2,4));
//console.log(exp2(2,4));

// console.log(fib(5));
