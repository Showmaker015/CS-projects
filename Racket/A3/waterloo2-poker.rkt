;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname waterloo2-poker) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define all-suit
  (cons 'C (cons 'D (cons 'H (cons 'S empty)))))

(define all-rank
  (cons 2
        (cons 3
              (cons 4
                    (cons 5
                          (cons 6
                                (cons 7
                                      (cons 8
                                            (cons 9
                                                  (cons 10
                                                        (cons 'J
                                                              (cons 'Q
                                                                    (cons 'K
                                                                          (cons 'A empty))))))))))))))

(define (rank c)
  (first c))

(define (suit c)
  (second c))

(define flush-hand-example
  (cons (cons 3 (cons 'H empty)) (cons (cons 'J (cons 'H empty)) empty)))

(define straight-hand-example
  (cons (cons 'J (cons 'S empty)) (cons (cons 'Q (cons 'D empty)) empty)))

(define straight-flush-hand-example
  (cons (cons 'J (cons 'H empty)) (cons (cons 10 (cons 'H empty)) empty)))

(define pair-hand-example
  (cons (cons 10 (cons 'H empty)) (cons (cons 10 (cons 'H empty)) empty)))

;; Question 2 a)
;; (ordinality c) produces the ordinality of a Card c

;; Examples:
(check-expect (ordinality (cons 2 (cons 'C empty))) 2)

;; ordinality: Card -> Nat
(define (ordinality c)
  (cond
    [(number? (rank c)) (rank c)]
    [(symbol=? (rank c) 'J) 11]
    [(symbol=? (rank c) 'Q) 12]
    [(symbol=? (rank c) 'K) 13]
    [else 14]))

;; Tests:
(check-expect (ordinality (cons 'J (cons 'C empty))) 11)
(check-expect (ordinality (cons 'Q (cons 'H empty))) 12)
(check-expect (ordinality (cons 'K (cons 'D empty))) 13)
(check-expect (ordinality (cons 'A (cons 'S empty))) 14)


;; Question 2 b)
(define (straight-flush hand)
  (cond 
    [(and (straight hand) (flush hand)) true]
    [else false]))

(define (pair hand)
  (cond
    [(= (ordinality (first hand)) (ordinality (second hand))) true]
    [else false]))

(define (straight hand)
  (cond
    [(= 1 (abs (- (ordinality (first hand)) (ordinality (second hand))))) true]
    [else false]))

(define (flush hand)
  (cond
    [(symbol=? (suit (first hand)) (suit (second hand))) true]
    [else false]))

;; (strength h) produces the strength of a Hand h

;; Examples:
(check-expect (strength flush-hand-example) 1)
(check-expect (strength straight-flush-hand-example) 4)

;; strength: Hand -> Nat
(define (strength h)
  (cond
    [(straight-flush h) 4]
    [(pair h) 3]
    [(straight h) 2]
    [(flush h) 1]
    [else 0]))

;; Tests:
(check-expect (strength (cons (cons 8 (cons 'S empty)) (cons (cons 'K (cons 'C empty)) empty))) 0)
(check-expect (strength straight-hand-example) 2)
(check-expect (strength pair-hand-example) 3)


;; Question 2 C)
;; (hand<? h1 h2) produces true if Hand h2 is better Hand h1, and false otherwise

;; Examples:
(check-expect (hand<? straight-hand-example straight-flush-hand-example) true)
(check-expect (hand<? pair-hand-example straight-hand-example) false)

;; hand<?: Hand Hand -> Bool
(define (hand<? h1 h2)
  (cond
    [(< (strength h1) (strength h2)) true]
    [else false]))


;; Tests:
(check-expect (hand<? flush-hand-example (cons (cons 8 (cons 'S empty))
                                               (cons (cons 'K (cons 'C empty)) empty))) false)
(check-expect (hand<? straight-flush-hand-example flush-hand-example) false)
(check-expect (hand<? flush-hand-example flush-hand-example) false)

;; Question 2 d)
;; (winner h1 h2) produces 'hand1 if the Hand h1 is better or 'hand2
;; if the Hand h2 is better and 'tie if both are equivalent

;; Examples:
(check-expect (winner straight-flush-hand-example flush-hand-example) 'hand1)
(check-expect (winner straight-hand-example pair-hand-example) 'hand2)

;; winner: Hand Hand -> Hand
(define (winner h1 h2)
  (cond
    [(< (strength h2) (strength h1)) 'hand1]
    [(< (strength h1) (strength h2)) 'hand2]
    [else 'tie]))

;; Tests:
(check-expect (winner flush-hand-example flush-hand-example) 'tie)
(check-expect (winner flush-hand-example straight-flush-hand-example) 'hand2)
(check-expect (winner straight-flush-hand-example pair-hand-example) 'hand1)


;; Question 2 e)
(define (rank-valid? rank)
  (cond
    [(member? rank all-rank) true]
    [else false]))

(define (suit-valid? suit)
  (cond
    [(member? suit all-suit) true]
    [else false]))

(define (valid-card? c)
  (cond
    [(and (suit-valid? (second c)) (rank-valid? (first c))
          (= (length c) 2)) true]
    [else false]))

(define (valid-both? c1 c2)
  (cond
    [(and (valid-card? c1) (valid-card? c2)) true]
    [else false]))

(define (valid-sequence? h)
  (cond
    [(and (cons? (first h)) (cons? (second h))
          (= (length h) 2) (valid-both? (first h) (second h))) true]
    [else false]))

;; (valid-hand? h) produces true if a Hand h is valid and false otherwise

;; Examples:
(check-expect (valid-hand? flush-hand-example) true)
(check-expect (valid-hand? straight-flush-hand-example) true)

;; hand<?: Any -> Bool
(define (valid-hand? h)
    (cond
      [(cons? h) (valid-sequence? h)]
      [else false]))

;; Tests:
(check-expect (valid-hand? (cons (cons "Hi" (cons 'H empty))
                                 (cons (cons 'J (cons 'H empty)) empty))) false)
(check-expect (valid-hand? (cons (cons 7 (cons "How" empty))
                                 (cons (cons 'J (cons 'H empty)) empty))) false)
(check-expect (valid-hand? 12345) false)
(check-expect (valid-hand? '()) false)
(check-expect (valid-hand? "Hello") false)