;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname draft) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (equiv-game? gm1 gm2)
  (local
    [(define tubes1 (game-tubes gm1))
     (define tubes2 (game-tubes gm2))
     (define helper1 (foldr append empty tubes1))
     (define helper2 (foldr append empty tubes2))]
    (and (equal? (sort (map symbol->string helper1) string<=?)
            (sort (map symbol->string helper2) string<=?))
         (equal? (game-tubesize gm1) (game-tubesize gm2))
         (equal? (game-maxcolours gm1) (game-maxcolours gm2))
         (equal? (length tubes1) (length tubes2)))))