;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname cs135search) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define il_example (list
                    (list "barks" (list "b.txt"))
                    (list "cat" (list "a.txt" "c.txt"))
                    (list "chases" (list "c.txt"))
                    (list "dog" (list "b.txt" "c.txt"))
                    (list "sleeps" (list "a.txt"))
                    (list "suddenly" (list "c.txt"))
                    (list "the" (list "a.txt" "b.txt" "c.txt"))))

(define (check string dl)
  (cond
    [(empty? dl) false]
    [(string<? string (first dl)) false]
    [(string=? string (first dl)) true]
    [else (check string (rest dl))]))

(define (determine str1 str2 an-il)
  (cond
    [(empty? an-il) empty]
    [(or (string=? str2 (first (first an-il))) (string=? str1 (first (first an-il))))
     (cons (second (first an-il)) (determine str1 str2 (rest an-il)))]
    [else (determine str1 str2 (rest an-il))]))


;; Question2 a)
;; (both) produces a doc-list that occur in both DLs
;; Examples
(check-expect (both (list "a.txt" "b.txt") (list "b.txt" "c.txt")) (list "b.txt"))
(check-expect (both (list "a.txt") (list "b.txt" "c.txt")) '())
(check-expect (both (list "c.txt") '()) '())

;; both: DL DL -> DL
(define (both dl1 dl2)
  (cond
    [(empty? dl1) '()]
    [(check (first dl1) dl2) (cons (first dl1) (both (rest dl1) dl2))]
    [else (both (rest dl1) dl2)]))

;; Tests
(check-expect (both (list "e.txt") (list "d.txt" "e.txt")) (list "e.txt"))
(check-expect (both (list "d.txt") (list "d.txt")) (list "d.txt"))


;; Question2 b)
;; (exclude) produces a doc-list that occur in the first DL but not the second
;; Examples
(check-expect (exclude (list "b.txt" "a.txt") (list "b.txt" "c.txt"))
              (list "a.txt"))
(check-expect (exclude (list "a.txt" "b.txt") (list "a.txt" "b.txt")) '())

;; exclude: DL Dl -> DL
(define (exclude dl1 dl2)
  (cond
    [(empty? dl1) '()]
    [(not (check (first dl1) dl2)) (cons (first dl1) (exclude (rest dl1) dl2))]
    [else (exclude (rest dl1) dl2)]))

;; Tests
(check-expect (exclude (list "d.txt" "e.txt") (list "e.txt")) (list "d.txt"))
(check-expect (exclude (list "e.txt") (list "e.txt")) '())
(check-expect (exclude (list "f.txt") (list "e.txt")) (list "f.txt"))


;; Question2 c)
;; (keys-retrieve) produces a (listof Str) with lexicographic ordering
;; Examples
(check-expect (keys-retrieve "b.txt" il_example) (list "barks" "dog" "the"))
(check-expect (keys-retrieve "c.txt" il_example)
              (list "cat" "chases" "dog" "suddenly" "the"))

;; keys-retrieve: Str IL -> listof Str
(define (keys-retrieve doc an-il)
  (cond
    [(empty? an-il) '()]
    [(check doc (second (first an-il)))
     (cons (first (first an-il)) (keys-retrieve doc (rest an-il)))]
    [else (keys-retrieve doc (rest an-il))]))

;; Tests
(check-expect (keys-retrieve "a.txt" il_example) (list "cat" "sleeps" "the"))
(check-expect (keys-retrieve "1.txt" il_example) '())

;; Question2 d)
;; (search) produces a doc-list of two possible formats
;; Examples
(check-expect (search 'both "dog" "cat" il_example) (list "c.txt"))
(check-expect (search 'exclude "dog" "the" il_example) '())

;; search: Sym Str Str IL -> DL
(define (search mode str1 str2 an-il)
  (cond
    [(symbol=? mode 'both)
     (both (first (determine str1 str2 an-il))
           (second (determine str1 str2 an-il)))]
    [(and (symbol=? mode 'exclude) (string<? str1 str2))
     (exclude (first (determine str1 str2 an-il))
              (second (determine str1 str2 an-il)))]
    [else (exclude (second (determine str1 str2 an-il))
              (first (determine str1 str2 an-il)))]))

;; Tests
(check-expect (search 'both "the" "sleeps" il_example) (list "a.txt"))
(check-expect (search 'exclude "dog" "chases" il_example) (list "b.txt"))
(check-expect (search 'exclude "sleeps" "barks" il_example) (list "a.txt"))