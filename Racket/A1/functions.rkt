;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define (manhattan-distance x1 y1 x2 y2)
  (+ (abs (- x1 x2)) (abs (- y1 y2))))

(define R 8.3144626)
(define (pressure n T V)
  (/ (* n R T) V))

(define (logit p)
  (log (/ p (- 1 p))))

(define (q s d t)
  (* s (exp (* -1 d t))))

(define (cone-area r h)
  (* pi r (+ r (sqrt (+ (sqr h) (sqr r))))))

(define (d1 maturity rate volatility spot-price strike-price)
  (* (/ 1 (* volatility (sqrt maturity)))
     (+ (log (/ spot-price strike-price))
        (* (+ rate (/ (sqr volatility) 2))
           maturity))))