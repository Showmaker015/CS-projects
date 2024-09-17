;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fizz-buzz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; (fizz-buzz) produces the Waterloo version of the “Fizz Buzz” sequence as a list
;; Examples
(check-expect (fizz-buzz 1 6 3 5) (list 1 2 'fizz 4 'buzz 'fizz))
(check-expect (fizz-buzz 15 20 3 5) (list 'honk 16 17 'fizz 19 'buzz))

;; fizz-buzz: Int Int Int Int -> List
(define (fizz-buzz start end fizz buzz)
  (cond
    [(= start end) (cons (fizz-buzz-judge start fizz buzz) empty)]
    [else (cons (fizz-buzz-judge start fizz buzz)
                (fizz-buzz (add1 start) end fizz buzz))]))
(define (fizz-buzz-judge num fizz buzz)
  (cond
    [(and (= (remainder num fizz) 0)
          (= (remainder num buzz) 0)) 'honk]
    [(= (remainder num fizz) 0) 'fizz]
    [(= (remainder num buzz) 0) 'buzz]
    [else num]))

;; Tests
(check-expect (fizz-buzz 10 16 6 7) (list 10 11 'fizz 13 'buzz 15 16))
(check-expect (fizz-buzz -5 0 2 4) (list -5 'honk -3 'fizz -1 'honk))
(check-expect (fizz-buzz 20 25 10 5) (list 'honk 21 22 23 24 'buzz))