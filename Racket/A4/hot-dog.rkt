;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname hot-dog) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; a)

;; (contains-hot-dog? loa) produces a boolean value showing whether a
;; list contains the symbol 'hot-dog 
;; Examples
(check-expect (contains-hot-dog? (cons 'hot-dog (cons 'cow empty))) true)
(check-expect (contains-hot-dog? (cons 'cat (cons 'car empty))) false)

;; contains-hot-dog?: (listof Any) -> Bool
(define (contains-hot-dog? lst)
  (and (not (empty? lst))
       (or (and (symbol? (first lst)) (symbol=? 'hot-dog (first lst)))
           (contains-hot-dog? (rest lst)))))

;; Tests
(check-expect (contains-hot-dog? empty) false)
(check-expect (contains-hot-dog? (cons 'teacher (cons 'professor empty))) false)
(check-expect (contains-hot-dog? (cons 'pizza (cons 'hot-dog (cons 'fish empty)))) true)


;; Question b)
;; (spells-hot-dog? str) produces a boolean value showing whether a string contains
;; the letters required to spell "hot dog"
;; Examples
(check-expect (spells-hot-dog? "hot dog") true)
(check-expect (spells-hot-dog? "abcd") false)

;; spells-hot-dog?: Str -> Bool
(define (spells-hot-dog? string)
  (and
   (contain "h" (string-downcase string))
   (contain "t" (string-downcase string))
   (contain "d" (string-downcase string))
   (contain "g" (string-downcase string))
   (contain " " (string-downcase string))
   (>= (two-o string) 2)))
(define (contain char string)
  (cond
    [(empty? (string->list string)) false]
    [(string=? char (substring string 0 1)) true]
    [else (contain char (substring string 1))]))
(define (two-o string)
  (cond
    [(empty? (string->list string)) 0]
    [(char=? #\o (first (string->list (string-downcase string))))
     (+ 1 (two-o (list->string (rest (string->list string)))))]
    [else (two-o (list->string (rest (string->list string))))]))

;; Tests
(check-expect (spells-hot-dog? " toodhg") true)
(check-expect (spells-hot-dog? "hotdog") false)
(check-expect (spells-hot-dog? "") false)
(check-expect (spells-hot-dog? "h otgo") false)
(check-expect (spells-hot-dog? "tdhg o") false)
(check-expect (spells-hot-dog? "hod tog") true)