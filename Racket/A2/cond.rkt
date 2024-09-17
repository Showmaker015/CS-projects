;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cond) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define (q3a p1? p2?)
  (cond
    [(and p1? p2?) 'left]
    [(and p1? (not p2?)) 'up]
    [(and (not p1?) p2?) 'down]
    [else 'right]))

(define (q3b p1? p2?)
  (cond
    [p1? 'up]
    [else 'down]))

(define (q3c p1? p2?)
  (cond
    [(and p1? (not p2?)) 'down]
    [else 'up]))