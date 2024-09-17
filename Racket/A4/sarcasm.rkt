;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname sarcasm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Question a)
;; pair-listof-X-template: List -> Any
(define (pair-listof-X-template lox)
  (cond
    [(empty? lox) ...]
    [(empty? (rest lox)) ...]
    [else (... (first lox) (... (second lox) (pair-listof-X-template (rest (rest lox)))))]))


;; Question b)
;; (sarcastic) produces the string in sarcasm case
;; Examples
(check-expect (sarcastic "Good morning") "GoOd mOrNiNg")
(check-expect (sarcastic "Welcome") "WeLcOmE")

;; sarcastic: Str -> Str
(define (sarcastic string)
  (cond
    [(empty? (string->list string)) ""]
    [(= (string-length string) 1) (string-upcase (substring string 0 1))]
    [else (string-append (string-upcase (substring string 0 1))
                         (string-downcase (substring string 1 2))
                         (sarcastic (substring string 2)))]))

;; Tests
(check-expect (sarcastic "") "")
(check-expect (sarcastic "No tests") "No tEsTs")
(check-expect (sarcastic "Welcome my friend") "WeLcOmE My fRiEnD")