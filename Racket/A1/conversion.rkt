;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname conversion) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
(define metres/mile 1609.344)
(define seconds/hour 3600)
(define (mph->m/s speed))
  (* (/ speed seconds/hour) meters/mile))

(define lbf->N 4.4482)
(define ft/in 12)
(define m/ft 0.3048)
(define (psi->pa p)
  (/ (* p lbf->N) (sqr (/ m/ft ft/in))))

(define (lbf-ft->Nm t)
  (* t lbf->N m/ft))