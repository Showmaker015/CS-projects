;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bonus) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define (final-cs135-grade cpg m1g m2g feg oag)
   (min (+ (* 0.05 cpg) (min (+ (* 0.07 m1g) (* 0.13 m2g) (* 0.30 feg)) 50) (min (* 0.45 oag) 50)) 46))

