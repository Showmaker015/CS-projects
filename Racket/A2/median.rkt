;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname median) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (median-of-3-simple a b c) produces the median of 3 numbers.
;; Examples:
(check-expect (median-of-3-simple 1 2 3) 2)
;; median-of-3-simple: Num Num Num -> Num

;; Definition:
(define (median-of-3-simple a b c) (cond
[(or (<= b a c) (<= c a b)) a]
[(or (<= a b c) (<= c b a)) b]
[else c]))

;; Tests:
(check-expect (median-of-3-simple 0 6 3) 3)
(check-expect (median-of-3-simple -1 5 3) 3)
(check-expect (median-of-3-simple 5 -2 1) 1)