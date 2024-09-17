;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname range) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; a)

;; (in-range a b lon) produces the number of elements in lon
;;   that are between a and b

;; Examples:
(check-expect (in-range 0 20 (list 5 10 20)) 3)
(check-expect (in-range 0 10 (list 5 10 20)) 2)

;; in-range: Num Num (Listof Num) -> Nat
(define (in-range a b lon)
  (cond [(empty? lon) 0]
        [(or (<= a (first lon) b)
             (<= b (first lon) a))
        (add1 (in-range a b (rest lon)))]
        [else (in-range a b (rest lon))]))

;; Test
(check-expect (in-range -10 5 empty) 0)
(check-expect (in-range -20 10 (list -21 5 10)) 2)
(check-expect (in-range -5 30 (list -3 45 15)) 2)
(check-expect (in-range 5 30 (list 5 10 30 22)) 4)
(check-expect (in-range 20 10 (list 3 6 16)) 1)


;; b)

;; (spread lon) produces the difference between max and min
;;   element in the non-empty list lon

;; Examples:
(check-expect (spread (list 5 38 92)) 87)
(check-expect (spread (list 3 50 4)) 47)

;; spread: (ne-listof Num) -> Num
(define (spread lon)
  (- (find-max lon) (find-min lon)))


;; (find-max lon) finds the largest element in lon

;; Examples:
(check-expect (find-max (list 8 6 7 5 3 0 9)) 9)
(check-expect (find-max (list 9)) 9)

;; find-max: (ne-listof Num) -> Num
(define (find-max lon)
  (cond [(empty? (rest lon)) (first lon)]
        [(> (first lon) (find-max (rest lon))) (first lon)]
        [else (find-max (rest lon))]))


;; (find-min lon) finds the smallest element in lon

;; Examples:
(check-expect (find-min (list 8 6 7 5 3 0 9)) 0)
(check-expect (find-min (list 9)) 9)

;; find-min: (ne-listof Num) -> Num
(define (find-min lon)
  (cond [(empty? (rest lon)) (first lon)]
        [(< (first lon) (find-min (rest lon))) (first lon)]
        [else (find-min (rest lon))]))

;; Test
(check-expect (spread (list 1)) 0)
(check-expect (spread (list 2 2)) 0)
(check-expect (spread (list 4 2)) 2)
(check-expect (spread (list 3 5)) 2)
(check-expect (spread (list 12 12 12)) 0)
(check-expect (spread (list 9 8 4)) 5)
(check-expect (spread (list 15 7 25)) 18)
(check-expect (spread (list 60 1 15 366)) 365)