function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
}

Student.prototype.name = function() {
  return this.fname + " " + this.lname;
};

Student.prototype.enroll = function(course){
  if (this.courses.indexOf(course) === -1){
    if(!this.hasConflict(course)){
      this.courses.push(course);
      course.addStudent(this);
    } else {
      return "course conflicts.";
    }
  }
};

Student.prototype.courseLoad = function () {
  var result = {};
  for (var i = 0; i < this.courses; i++) {
    var course = this.courses[i];
    var department = course.department;
    if ( result[department] === undefined ){
      result[department] = course.credits;
    } else {
      result[department] += course.credits;
    }
    return result;
  }
};

Student.prototype.hasConflict = function(newCourse){
  for(var i = 0; i < this.courses.length; i++){
    var course = this.courses[i];
    if (course.conflictsWith(newCourse)){
      return true;
    }
  }
  return false;
};

function Course(name, department, credits, days, timeBlock) {
  this.name = name;
  this.deparment = department;
  this.credits = credits;
  this.students = [];
  this.days = days;
  this.timeBlock = timeBlock;
}

Course.prototype.addStudent = function(student) {
  if (this.students.indexOf(student) === -1) {
    this.students.push(student);
    student.enroll(this);
  }
};

Course.prototype.conflictsWith = function(course) {
  if ( this.timeBlock === course.timeBlock ) {
    // do stuff
    for (var i = 0 ; i < this.days.length; i++){
      var day = this.days[i];
      for(var j = 0; j < course.days.length; j++){
        var otherDay = course.days[j];
        if (day === otherDay){
          return true;
        }
      }
    }
  } else {
    return false;
  }
};

var student1 = new Student("oscar", "garcia");
var student2 = new Student("chris", "pauley");
var course1 = new Course("pdes", "math", 4, ['mon', 'wed', 'fri'], 8);
var course2 = new Course("underwater basket weaving", "sociology", 8, ['tue', 'thu'], 81 );
var course3 = new Course("Linear Algebra", "math", 4, ['mon', 'wed', 'fri'], 8);

student1.enroll(course1);
student1.enroll(course2);
student1.enroll(course3);
student2.enroll(course1);
student2.enroll(course3);
console.log(student1.courses);
//console.log(course1.students);
