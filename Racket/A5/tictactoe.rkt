;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname tictactoe) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define grid1
  (list (list '_ '_ '_)
        (list '_ '_ '_)
        (list '_ '_ '_)))

(define grid2
  (list (list 'X 'O 'O 'O '_)
        (list 'X 'X 'O '_ '_)
        (list '_ '_ '_ '_ '_)
        (list '_ '_ '_ '_ '_)
        (list '_ '_ '_ '_ 'X)))

(define grid3
  (list (list 'X)))

(define grid4
  (list (list '_ '_ 'O)
        (list 'X 'X 'O)
        (list '_ 'X '_)))

(define grid5
  (list (list 'O '_ 'X)
        (list 'X 'X 'O)
        (list 'O 'X 'O)))

(define grid6
  (list (list 'O 'O 'X)
        (list 'X 'O 'O)
        (list 'X '_ 'X)))

(define (subvalue t3row)
  (cond
    [(empty? t3row) 0]
    [(symbol=? (first t3row) 'X) (+ 1 (subvalue (rest t3row)))]
    [(symbol=? (first t3row) 'O) (- (subvalue (rest t3row)) 1)]
    [else (subvalue (rest t3row))]))

(define (value t3grid)
  (cond
    [(empty? t3grid) 0]
    [else (+ (subvalue (first t3grid)) (value (rest t3grid)))]))

(define (win_a_row target_row column player)
  (cond
    [(empty? target_row) 0]
    [(symbol=? player (first target_row))
     (+ 1 (win_a_row (rest target_row) column player))]
    [else (win_a_row (rest target_row) column player)]))

(define (win_a_column target_column row player)
  (cond
    [(empty? target_column) 0]
    [(symbol=? player (first target_column))
     (+ 1 (win_a_column (rest target_column) row player))]
    [else (win_a_column (rest target_column) row player)]))


;; Question3 a)
;; (whose-turn) determines whose turn it is
;; Examples
(check-expect (whose-turn grid2) 'X)
(check-expect (whose-turn grid1) 'X)

;; who-turn: T3Grid -> Sym
(define (whose-turn t3grid)
  (cond
    [(= 0 (value t3grid)) 'X]
    [else 'O]))

;; Tests
(check-expect (whose-turn grid3) 'O)
(check-expect (whose-turn grid4) 'O)


;; Question3 b)
;; (grid-ref) produces the symbol located at a specific row and column number
;; Examples
(check-expect (grid-ref grid1 2 1) '_)
(check-expect (grid-ref grid2 4 4) 'X)

;; grid-ref: T3Grid Nat Nat -> Sym
(define (grid-ref t3grid row column)
  (list-ref (list-ref t3grid row) column))

(check-expect (grid-ref grid3 0 0) 'X)
(check-expect (grid-ref grid4 0 1) '_)


;; Question3 c)
;; (get-column) produces a list of the symbols in a specific column
;; Examples
(check-expect (get-column grid1 2) (list '_ '_ '_))
(check-expect (get-column grid2 3) (list 'O '_ '_ '_ '_))
(check-expect (get-column grid3 0) (list 'X))

;; T3Grid Nat -> List
(define (get-column t3grid column)
  (cond
    [(empty? t3grid) empty]
    [else (cons (list-ref (first t3grid) column)
                (get-column (rest t3grid) column))]))

;; Tests
(check-expect (get-column grid2 2) (list 'O 'O '_ '_ '_))
(check-expect (get-column grid4 1) (list '_ 'X 'X))


;; Question3 d)
;; (will-win?) produces whether a player would win by placing
;; a marker at the given location 
;; Examples
(check-expect (will-win? grid3 0 0 'O) false)
(check-expect (will-win? grid2 4 3 'X) false)

;; will-win?: T3Grid Nat Nat Sym -> Bool
(define (will-win? t3grid row column player)
  (cond
    [(or (symbol=? 'X (grid-ref t3grid row column))
         (symbol=? 'O (grid-ref t3grid row column))) false]
    [(= (- (length (first t3grid)) 1)
        (win_a_row (list-ref t3grid row) column player)) true]
    [(= (- (length t3grid) 1)
        (win_a_column (get-column t3grid column) row player)) true]
    [else false]))

;; Tests
(check-expect (will-win? grid4 2 2 'O) true)
(check-expect (will-win? grid5 0 1 'X) true)
(check-expect (will-win? grid6 2 1 'X) true)