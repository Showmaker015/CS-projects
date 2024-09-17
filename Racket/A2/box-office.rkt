;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname box-office) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (box-office-profits Name-of-the-movie Name-of-a-studio
;; Number-of-famous-actors Number-of-explosions) produces
;; the predicted box office profits (as an Int) in millions.
;; Examples:
(check-expect (box-office-profits "Thor: Love and Thunder" "Marvel" 4 50 ) 980)
;; box-office-profits: Str Str Nat Nat -> Int

(define (box-office-profits Name-of-the-movie Name-of-a-studio
                            Number-of-famous-actors Number-of-explosions)
  (+ (cond
       [(< (string-length Name-of-the-movie) 10) 25]
       [else 0])
     (cond
       [(string=? (substring Name-of-the-movie 0 3) "The") -50]
       [else 0])
     (cond
       [(string=? Name-of-a-studio "Marvel") 500]
       [else 0])
     (cond
       [(string=? Name-of-a-studio "DC") -250]
       [else 0])
     (* 50 Number-of-famous-actors)
     (+ -20 (* 6 Number-of-explosions))))

(check-expect (box-office-profits "Man of Steel" "DC" 7 55 ) 410)
(check-expect (box-office-profits "Star Wars" "Walt Disney" 7 60 ) 715)
(check-expect (box-office-profits "The Avengers" "Marvel" 11 40 ) 1220)
