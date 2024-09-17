;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname tubes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "lib-tubes.rkt")

;; A Game is (make-game Nat Nat (listof (listof Sym)))
(define-struct game (tubesize maxcolours tubes))

;;; Constants

(define emptygame
  (make-game 0 5
             (list empty empty empty empty empty)))

(define emptygame2
  (make-game 10 3 empty))

(define emptygame3
  (make-game 10 3 (list empty empty)))

(define smallgame1
  (make-game 2 2
             (list (list 'blue 'red)
                   (list 'blue 'red)
                   (list))))

(define smallgame2
  (make-game 2 3
             (list (list 'blue 'red)
                   (list 'blue 'red)
                   (list))))

(define smallinvalidgame1
  (make-game 2 1
             (list (list 'blue 'red)
                   (list 'blue 'red)
                   (list))))


(define smallinvalidgame2
  (make-game 2 2
             (list (list 'blue 'red)
                   (list 'blue 'blue)
                   (list))))

(define smallinvalidgame3
  (make-game 2 2
             (list (list 'blue 'red 'blue)
                   (list 'red)
                   (list))))


(define smallgamefinal
  (make-game 2 2
             (list (list)
                   (list 'blue 'blue)
                   (list 'red 'red))))


(define mediumgame
  (make-game 2 3
             (list (list 'blue 'red)
                   (list 'red 'yellow)
                   (list 'yellow 'blue)
                   (list))))

(define mediumgamestuck
  (make-game 2 3
             (list (list 'blue 'red)
                   (list 'red 'yellow)
                   (list 'yellow 'blue)
                   )))

(define largergame
  (make-game 3 3
             (list (list 'blue 'red 'red)
                   (list 'yellow 'blue 'yellow)
                   (list 'red 'yellow 'blue)
                   (list))))

(define biggame
  (make-game 5 3
             (list (list 'blue 'blue 'red 'red 'yellow)
                   (list 'red 'red 'yellow 'blue 'red)
                   (list 'yellow 'blue 'blue 'yellow 'yellow)
                   (list)
                   (list))))

(define biggame2
  (make-game 5 3
             (list (list 'yellow 'blue 'blue 'yellow 'yellow)
                   (list 'red 'red 'yellow 'blue 'red)
                   (list)
                   (list 'blue 'blue 'red 'red 'yellow)
                   (list))))

(define biggamesolve
  (make-game 5 3
             (list (list 'blue 'blue 'blue 'blue 'blue)
                   (list 'red 'red 'red 'red 'red)
                   (list 'yellow 'yellow 'yellow 'yellow 'yellow)
                   (list)
                   (list))))

(define hugegame
  (make-game 4 9
             (list (list 'purple 'pink 'yellow 'blue)
                   (list 'blue 'green 'purple 'white)
                   (list 'orange 'yellow 'black 'blue)
                   (list 'white 'orange 'orange 'pink)
                   (list 'pink 'red 'red 'black)
                   (list 'yellow 'green 'orange 'blue)
                   (list 'white 'purple 'red 'yellow)
                   (list 'green 'red 'green 'black)
                   (list 'purple 'black 'white 'pink)
                   (list)
                   (list))
             ))

;; stubs for finished-game? and next-games
;; Students will need to modify these functions to make solve work correctly
;; These stubs will at least allow the entire program to run without error

(define (next-games gm)
  empty)

;;;;;

;; (solve gm draw-option) determines if the game gm is solveable,
;; and will also draw each possible move depending on the draw-option

;; Examples:
;; students should provide some here, or just in tests

;; solve: Game (anyof 'off 'norm 'slow 'fast) -> Bool

(define (solve gm draw-option)
  (local
    [(define setup (puzzle-setup gm draw-option))                
     (define (solve-helper to-visit visited)
       (cond
         [(empty? to-visit) false]
         [else
          (local
            [(define draw (draw-board (first to-visit) draw-option))] 
            (cond
              [(finished-game? (first to-visit)) true]
              [(member? (first to-visit) visited)
               (solve-helper (rest to-visit) visited)]
              [else
               (local [(define nbrs (next-games (first to-visit)))
                       (define new (filter (lambda (x) (not (member? x visited))) nbrs))
                       (define new-to-visit (append new (rest to-visit)))
                       (define new-visited (cons (first to-visit) visited))]
                 (solve-helper new-to-visit new-visited))]))]))]
    (solve-helper (list gm) empty)))

;; Test cases that can be uncommented as the solution is completed

;(check-expect (solve smallgame1 'slow) true)
;(check-expect (solve mediumgamestuck 'slow) false)

;; Below is the format for testing and timing the solution:
;; be sure to remove any other check-expects when measuring your timing

;(check-expect (time (solve mediumgame 'off)) true)
;(check-expect (time (solve largergame 'off)) true)
;(check-expect (time (solve biggame 'off)) true)
;(check-expect (time (solve hugegame 'off)) true)


;; 1 (a)
;; (check-colour? size num los) produces whether each symbol in the list appears
;;   exactly size times and if there are at most num different symbols

;; Examples:
(check-expect (check-colour? 5 1 (list 'red 'red 'red 'red 'red)) true)
(check-expect (check-colour? 5 2 (list 'red 'blue 'yelllow 'red 'red)) false)

;; check-colour?: Nat Nat (listof Sym) -> Bool
(define (check-colour? size num los)
  (local
    [(define helper (foldr (lambda (x y)
                             (cond
                               [(member? x y) y]
                               [else (cons x y)])) empty los))]
    (and (or (= num (length helper)) (> num (length helper)))
         (andmap (lambda (x) (= (length (filter (lambda (y) (symbol=? y x)) los)) size))
                 helper))))

;; Tests:
(check-expect (check-colour? 5 2 (list 'red 'red 'red 'red 'red)) true)
(check-expect (check-colour? 1 4 (list 'orange 'blue 'red 'purple)) true)
(check-expect (check-colour? 2 3 (list 'orange 'orange 'red 'purple 'red)) false)
(check-expect (check-colour? 2 2 (list 'orange 'orange 'red 'purple 'red)) false)
(check-expect (check-colour? 0 2 '()) true)


;; 1 (b)
;; (valid-game? gm) produces whether gm is a valid game

;; Examples:
(check-expect (valid-game? smallgame1) true)
(check-expect (valid-game? smallinvalidgame1) false)

;; valid-game?: Game -> Bool
(define (valid-game? gm)
  (local
    [(define tubesize (game-tubesize gm))
     (define colour (game-maxcolours gm))
     (define tubes (game-tubes gm))
     (define helper (foldr append empty tubes))
     (define helper2 (foldr (lambda (x y)
                             (cond
                               [(member? x y) y]
                               [else (cons x y)])) empty helper))]
    (and (or (= colour (length helper2)) (> colour (length helper2)))
         (andmap (lambda (x) (= (length (filter (lambda (y) (symbol=? y x)) helper))
                                tubesize)) helper)
         (andmap (lambda (x) (or (= tubesize (length x)) (> tubesize (length x))))
                 tubes))))

;; Tests:
(check-expect (valid-game? emptygame) true)
(check-expect (valid-game? smallgame2) true)
(check-expect (valid-game? smallinvalidgame2) false)


;; 1 (c)
;; (remove-completed gm) produces a Game which is similar to gm but has any completed
;;  tubes removed

;; Examples:
(check-expect (remove-completed smallgame1) (make-game 2 2
                                                       (list (list 'blue 'red)
                                                             (list 'blue 'red)
                                                             (list))))
(check-expect (remove-completed smallgamefinal) (make-game 2 0 (list (list))))
(check-expect (remove-completed (make-game 2 2
                                           (list (list 'red)
                                                 (list 'blue 'blue)
                                                 (list 'red))))
              (make-game 2 1
                         (list (list 'red)
                               (list 'red))))

;; remove-completed: Game -> Game



;; 1 (d)
;; (finished-game? gm) produces whether the game is finished

;; Examples:
(check-expect (finished-game? emptygame) true)
(check-expect (finished-game? smallgame1) false)


;; finished-game?: Game -> Bool
(define (finished-game? gm)
  (local
    [(define tubes (game-tubes gm))
     (define (same-colour? lst)
       (andmap (lambda (x) (symbol=? x (first lst))) lst))]
    (andmap same-colour? tubes)))

;; Tests:
(check-expect (finished-game? hugegame) false)
(check-expect (finished-game? smallgamefinal) true)


;; 1 (e)
;; (num-blocks llos) produces the number of "blocks" contained in llos

;; Examples:
(check-expect (num-blocks (list empty '(a a) '(a a a))) 2)
(check-expect (num-blocks (list empty empty)) 0)
(check-expect (num-blocks (list '(a b c a a) '(a a a b))) 6)

;; num-blocks: (listof (listof sym)) -> Nat


;; 1 (f)
;; (equiv-game? gm1 gm2) produces whether gm1 and gm2 are equivalent

;; Examples:
(check-expect (equiv-game? smallgame1 smallgame1) true)
(check-expect (equiv-game? mediumgame
                           (make-game 2 3
                                      (list (list 'red 'yellow)
                                            (list 'blue 'red)
                                            (list 'yellow 'blue)
                                            (list)))) true)
(check-expect (equiv-game? smallgame1
                           (make-game 2 2
                                      (list (list 'blue 'red)
                                            (list 'blue 'red)))) false)
(check-expect (equiv-game? smallgame1
                           (make-game 2 2
                                      (list (list 'blue 'red)
                                            (list 'blue 'red)))) false)

;; equiv-game?: Game Game -> Bool
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

;; Tests:
(check-expect (equiv-game? smallgame1
                           (make-game 1 2
                                      (list (list 'blue)
                                            (list 'red)))) false)
(check-expect (equiv-game? smallgame1
                           (make-game 2 2
                                      (list (list 'blue 'red)
                                            (list 'red 'blue)
                                            (list)))) false)


;; 1 (g)
;; (all-equiv? log1 log2) produces whether every game in log1 has one equivalent game in
;;   log2, and every game in log2 has one equivalent game in log1,

;; Examples:
(check-expect (all-equiv? (list smallgame1 smallgame2)
                          (list smallgame1 smallgame2)) true)
(check-expect (all-equiv? (list smallgame1 smallgame2)
                          (list (make-game 2 2
                                           (list (list 'blue 'red)
                                                 (list 'blue 'red))) mediumgame)) false)
(check-expect (all-equiv? (list smallgame1 mediumgame)
                          (list (make-game 2 3
                                           (list (list 'red 'yellow)
                                                 (list 'blue 'red)
                                                 (list 'yellow 'blue)
                                                 (list))) smallgame1)) true)

;; all-equiv?: (listof Game) (listof Game) -> Bool


;; 1 (h)
;; (next-games gm) produces a list of Games that can happen by moving one ball from gm

;; Examples:
(check-expect (test-next-games smallgame1 (list
                                           (make-game 2 2
                                                      (list (list 'blue 'red)
                                                            (list 'red)
                                                            (list 'blue)))
                                           (make-game 2 2
                                                      (list (list 'red)
                                                            (list 'red)
                                                            (list 'blue 'blue)))
                                           smallgamefinal)) false)

;; next-games: Game -> (listof Game)