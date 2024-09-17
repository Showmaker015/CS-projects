;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname nat-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Question a)
;; (nat->list) converts a natural number n into a list of Digits
;; Examples
(check-expect (nat->list 131) (list 1 3 1))
(check-expect (nat->list 305) (list 5 0 3))

;; nat->list: Nat -> List
(define (nat->list number)
  (cond
    [(= 0 number) (cons 0 empty)]
    [(and (< 0 number) (> 10 number)) (cons number empty)]
    [else (cons (remainder number 10)
                (nat->list (/ (- number (remainder number 10)) 10)))]))

;; Tests
(check-expect (nat->list 0) (list 0))
(check-expect (nat->list 2356) (list 6 5 3 2))
(check-expect (nat->list 1854272) (list 2 7 2 4 5 8 1))


;; Question b)
;; (list->nat) converts a non-empty list of Digits back into a natural number
;; Examples
(check-expect (list->nat (list 9 7 5)) 579)
(check-expect (list->nat (list 0 3 5)) 530)

;; list->nat: List -> Nat
(define (list->nat num-list)
  (recurse-list num-list 0 (length num-list)))
(define (recurse-list num-list base length)
    (cond
        [(= (sub1 length) base) (* (first num-list) (expt 10 base))]
        [else (+ (* (first num-list) (expt 10 base))
                 (recurse-list (rest num-list) (add1 base) length))]))

;; Tests
(check-expect (list->nat (list 0)) 0)
(check-expect (list->nat (list 3 6 7 5)) 5763)
(check-expect (list->nat (list 5 6)) 65)