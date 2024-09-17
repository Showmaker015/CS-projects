;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname blood) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))
;; (can-donate-to/cond? x y) produces whether the
;; donor’s blood type is acceptable for the recipient’s blood type.
;; Examples:
(check-expect (can-donate-to/cond? 'O- 'O-) true)
;; Can-donate-to/cond? x y: Sym Sym -> Bool 
;; Definition
(define (can-donate-to/cond? Donor Recipient)
(cond
  [(symbol=? Donor 'O-) true]
  [(symbol=? Recipient 'AB+) true]
  [(symbol=? Donor Recipient) true]
  [(symbol=? Donor 'O+) (cond
                         [(symbol=? Recipient 'A+) true]
                         [(symbol=? Recipient 'B+) true]
                         [else false])]
  [(symbol=? Donor 'A-) (cond
                         [(symbol=? Recipient 'A+) true]
                         [(symbol=? Recipient 'AB-) true]
                         [else false])]
  [(symbol=? Donor 'B-) (cond
                         [(symbol=? Recipient 'B+) true]
                         [(symbol=? Recipient 'AB-) true]
                         [else false])]
  [else false]))
;; Tests
(check-expect (can-donate-to/cond? 'O+ 'B+) true)
(check-expect (can-donate-to/cond? 'B- 'AB+) true)
(check-expect (can-donate-to/cond? 'A- 'B-) false)

;; (can-donate-to/bool? x y) produces whether the
;; donor’s blood type is acceptable for the recipient’s blood type.
;; Examples:
(check-expect (can-donate-to/bool? 'O- 'B-) true)
;; can-donate-to/cond? x y: Sym Sym -> Bool
;; Definition
(define (can-donate-to/bool? Donor Recipient)
(or (symbol=? Donor 'O-) (symbol=? Recipient 'AB+) (symbol=? Donor Recipient)
    (and (symbol=? Donor 'O+) (or (symbol=? Recipient 'A+) (symbol=? Recipient 'B+)))
    (and (symbol=? Donor 'A-) (or (symbol=? Recipient 'A+) (symbol=? Recipient 'AB-)))
    (and (symbol=? Donor 'B-) (or (symbol=? Recipient 'B+) (symbol=? Recipient 'AB-)))))
;; Tests
(check-expect (can-donate-to/bool? 'A+ 'B+) false)
(check-expect (can-donate-to/bool? 'AB+ 'AB-) false)
(check-expect (can-donate-to/bool? 'B- 'AB-) true)

