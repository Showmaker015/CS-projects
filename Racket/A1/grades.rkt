;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname grades) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; Weights of the grade components
(define midterm1-weight     7/100)
(define midterm2-weight     13/100)
(define final-weight        30/100)
(define assignment-weight   45/100)
(define participation-weight 5/100)
(check-expect (final-cs135-grade 100 100 100 100 100) 100)
(check expect (final-cs135-grade 0 0 0 0 0) 0)
(define (final-cs135-grade participation-grade
                           midterm1-grade midterm2-grade
                           final-grade assignment-grade)
  (+ (* midterm1-grade      midterm1-weight)
     (* midterm2-grade      midterm2-weight)
     (* final-grade         final-weight)
     (* assignment-grade    assignment-weight)
     (* participation-grade participation-weight)))
(check-expect (final-cs135-grade 100 0 0 0 0) 5)
(check-expect (final-cs135-grade 0 100 0 0 0) 7)
(check-expect (final-cs135-grade 0 0 100 0 0) 13)
(check-expect (final-cs135-grade 0 0 0 100 0) 30)
(check-expect (final-cs135-grade 0 0 0 0 100) 45)
(check-expect (final-cs135-grade 50 50 50 50 50) 50)
(check-expect (final-cs135-grade 70 90 80 74 86) 81.1)

(define min-grade-needed 60)
(check-expect (cs135-final-exam-grade-needed 100 100 100 100) -100/3)
(define (cs135-final-exam-grade-needed participation-grade
                                       midterm1-grade midterm2-grade
                                       assignment-grade)
  (/ (- min-grade-needed
        