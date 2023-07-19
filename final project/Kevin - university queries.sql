-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL,
  `term_name` VARCHAR(45) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`faculty` ;

CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT NOT NULL,
  `faculty_fname` VARCHAR(45) NOT NULL,
  `faculty_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL,
  `college_name` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_code` VARCHAR(5) NOT NULL,
  `department_name` VARCHAR(100) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_code`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL,
  `course_num` INT(3) NOT NULL,
  `course_title` VARCHAR(45) NOT NULL,
  `credits` INT NOT NULL,
  `department_code` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department1_idx` (`department_code` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_code`)
    REFERENCES `university`.`department` (`department_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL,
  `section_num` INT NOT NULL,
  `capacity` INT NOT NULL,
  `term_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `fk_student_has_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_section_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_section_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- INSERT STATEMENTS

USE university;

INSERT INTO college VALUES
	(1,'College of Physical Science and Engineering'),
    (2,'College of Business and Communication'),
    (3,'College of Language and Letters');
    
SELECT * FROM college;
    
INSERT INTO department VALUES
	('CIT','Computer Information Technology',1),
    ('ECON','Economics',2),
    ('HUM','Humanities and Philosophy',3);
    
SELECT * FROM department;
    
INSERT INTO course VALUES
	(1,111,'Intro to Databases', 3,'CIT'),
    (2,388,'Econometrics', 4,'ECON'),
    (3,150,'Micro Economics', 3,'ECON'),
    (4,376,'Classical Heritage', 2,'HUM');
    
SELECT * FROM course;
    
INSERT INTO term VALUES
	(1, 'Fall', 2019),
    (2, 'Winter', 2018);
    
SELECT * FROM term;
    
INSERT INTO faculty VALUES
	(1,'Marty', 'Morring'),
    (2,'Nate', 'Nathan'),
    (3,'Ben', 'Barrus'),
    (4,'John', 'Jensen'),
    (5,'Bill', 'Barney');
    
SELECT * FROM faculty;
    
INSERT INTO student VALUES
	(1,'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
    (2,'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
    (3,'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
    (4,'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
    (5,'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
    (6,'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
    (7,'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
    (8,'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
    (9,'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
    (10,'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');
    
SELECT * FROM student;
    
INSERT INTO section VALUES
	(1, 1, 30, 1, 1, 1), -- Fall 2019 CIT 111 section 1
    (2, 1, 50, 1, 2, 3), -- Fall 2019 ECON 150 section 1
    (3, 2, 50, 1, 2, 3), -- Fall 2019 ECON 150 section 2
    (4, 1, 35, 1, 3, 2), -- Fall 2019 ECON 388 section 1
    (5, 1, 30, 1, 4, 4), -- Fall 2019 HUM 376 section 1
    (6, 2, 30, 2, 1, 1), -- Winter 2018 CIT 111 section 2
    (7, 3, 35, 2, 5, 1), -- Winter 2018 CIT 111 section 3
    (8, 1, 50, 2, 2, 3), -- Winter 2019 ECON 150 section 1
    (9, 2, 50, 2, 2, 3), -- Winter 2018 ECON 150 section 2
    (10, 1, 30, 2, 4, 4); -- Winter 2018 HUM 376 section 1
    
SELECT * FROM section;
    
INSERT INTO enrollment VALUES
	(6, 7), -- Alece enrollling in CIT 111 Winter 2018  section 3
    (7, 6), -- Bryce enrollling in CIT 111 Winter 2018 section 2
    (7, 8), -- Bryce enrollling in ECON 150 Winter 2018 section 1
    (7, 10), -- Bryce enrollling in HUM 376 Winter 2018 section 1
    (4, 5), -- Devon enrollling in HUM 376 Fall 2019 section 1
    (9, 9),-- Julia enrollling in ECON 150 Winter 2018 section 2
    (2, 4), -- Katie enrollling in ECON 388 Fall 2019 section 1
    (3, 4), -- Kelly enrollling in ECON 388 Fall 2019 section 1
    (5, 4), -- Mandy enrollling in ECON 388 Fall 2019 section 1
    (5, 5), -- Mandy enrollling in HUM 376 Fall 2019 section 1
    (1, 1), -- Paul enrollling in CIT 111 Fall 2019 section 1
    (1, 3), -- Paul enrollling in ECON 150 Fall 2019 section 2
    (8, 9), -- Preston enrollling in ECON 150 Winter 2018 section 2
    (10, 6); -- Susan enrollling in CIT 111 Winter 2018 section 2
    
SELECT * FROM enrollment;

-- PART 2
-- Query 1: Students, and their birthdays, of students born in September. Format the date to look like it is
-- shown in the result set. Sort by the student's last name.

USE university;

SELECT first_name AS 'fname', last_name AS 'lname', DATE_FORMAT(birthdate, '%M %d, %Y') AS 'Sept Birthdays'
FROM student
WHERE MONTH(birthdate) = 9
ORDER BY last_name;
    
-- Query 2: Student's age in years and days as of Jan. 5, 2017.  Sorted from oldest to youngest.  (You can
-- assume a 365 day year and ignore leap day.) Hint: Use modulus for days left over after years. The 5th
-- column is just the 3rd and 4th column combined with labels.

SELECT last_name AS 'lname', first_name AS 'fname',
	FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) AS 'Years',
	MOD(DATEDIFF('2017-01-05', birthdate), 365) AS 'Days',
	CONCAT(FLOOR(DATEDIFF('2017-01-05', birthdate)/365), ' - Yrs, ', MOD(DATEDIFF('2017-01-05', birthdate), 365), ' - Days') AS 'Years and Days'
FROM student
ORDER BY DATEDIFF('2017-01-05', birthdate) DESC;

-- Query 3: Students taught by John Jensen. Sorted by student's last name

SELECT first_name AS 'fname', last_name AS 'lname'
FROM student s
	JOIN enrollment e
		ON s.student_id = e.student_id
    JOIN section se
		ON e.section_id = se.section_id
    JOIN faculty f
		ON se.faculty_id = f.faculty_id
WHERE f.faculty_lname = 'Jensen' and f.faculty_fname = 'John'
ORDER BY s.last_name;

-- Query 4:   Instructors Bryce will have in Winter 2018. Sort by the faculty's last name.

SELECT faculty_fname AS 'fname', f.faculty_lname AS 'lname'
FROM faculty f
	JOIN section s
		ON f.faculty_id = s.faculty_id
    JOIN term t
		ON s.term_id = t.term_id
    JOIN enrollment e
		ON e.section_id = s.section_id
    JOIN student st
		ON e.student_id = st.student_id
WHERE st.first_name = 'Bryce'
	AND t.year = 2018
	AND t.term_name = 'Winter'
ORDER BY f.faculty_lname;

-- Query 5: Students that take Econometrics in Fall 2019. Sort by student last name.

SELECT first_name AS 'fname', last_name AS 'lname'
FROM section s
	JOIN term t
		ON s.term_id = t.term_id
	JOIN enrollment e
		ON e.section_id = s.section_id
	JOIN student st
		ON e.student_id = st.student_id
	JOIN course c
		ON s.course_id = c.course_id
WHERE c.course_title = 'Econometrics'
	AND t.year = 2019
    AND t.term_name = 'Fall'
ORDER BY st.last_name;

-- Query 6: Report showing all of Bryce Carlson's courses for Winter 2018. Sort by the name of the course.

SELECT department_code, course_num, course_title AS 'name'
FROM term t
	JOIN section s
		ON t.term_id = s.term_id
	JOIN course c
		ON s.course_id = c.course_id
	JOIN enrollment e
		ON s.section_id = e.section_id
	JOIN student st
		ON e.student_id = st.student_id
WHERE st.last_name = 'Carlson' AND term_name = 'Winter' AND year = 2018
ORDER BY c.course_title;

-- Query 7: The number of students enrolled for Fall 2019

SELECT term_name AS 'term', year, COUNT(s.section_id) AS 'Enrollment'
FROM term t
	JOIN section s
		ON t.term_id = s.term_id
	JOIN enrollment e
		ON s.section_id = e.section_id
WHERE term_name = 'Fall' AND year = 2019;

-- Query 8: The number of courses in each college. Sort by college name.

SELECT college_name AS 'Colleges', COUNT(course_id) AS 'Courses'
FROM college c
	JOIN department d
		ON c.college_id = d.college_id
	JOIN course co
		ON d.department_code = co.department_code
GROUP BY college_name
ORDER BY college_name;

-- Query 9: The total number of students each professor can teach in Winter 2018. Sort by that total 
-- number of students (teaching capacity).

SELECT faculty_fname AS 'fname', faculty_lname AS 'lname', SUM(capacity) AS 'TeachingCapacity'
FROM faculty f
	JOIN section s
		ON f.faculty_id = s.faculty_id
	JOIN term t
		ON s.term_id = t.term_id
WHERE term_name = 'Winter' AND year = 2018
GROUP BY f.faculty_lname, f.faculty_fname
ORDER BY SUM(capacity);

-- Query 10: Each student's total credit load for Fall 2019, but only students with a credit load greater than
-- three.  Sort by credit load in descending order. 

SELECT DISTINCT last_name AS 'lname', first_name AS 'fname', SUM(c.credits) AS 'Credits'
FROM student s
	JOIN enrollment e
		ON s.student_id = e.student_id
	JOIN section se
		ON e.section_id = se.section_id
	JOIN term t
		ON se.term_id = t.term_id
    JOIN course c
		ON se.course_id = c.course_id
WHERE term_name = 'Fall' AND year = 2019
GROUP BY last_name, first_name
HAVING SUM(c.credits) > 3
ORDER BY SUM(c.credits) DESC;




