(use-modules (srfi srfi-1)) ;split-at
(use-modules (srfi srfi-11)) ;let-values

(define pack-size (read))

(define (make-pack n c pack)
  (if (< c n)
      (make-pack n (1+ c) (append pack (list c)))
      pack))

(display (make-pack pack-size 0 '()))(newline)
(define test-pack (make-pack 10 0 '()))

;deal into new stack
(define (deal-into p)
  (reverse p))

(display (deal-into test-pack))(newline)

;cut n cards, positive
(define (cut-cards-pos n p)
  (let-values (((head tail) (split-at p n)))
    (append tail head)))

(display (cut-cards-pos 3 test-pack))(newline)

;cut n cards, negative
(define (cut-cards-neg n p l)
  (let-values (((head tail) (split-at p (- l n))))
    (append tail head)))

(display (cut-cards-neg 4 test-pack 10))(newline)

;deal with increment n
(define (deal-with-inc n p l ci res)
  (define cj (floor (modulo (+ ci n) l)))
  (if (null? p)
      res
      (begin
	(list-set! res ci (car p))
	(deal-with-inc n (cdr p) 10 cj res))))

(display (deal-with-inc 3 test-pack 10 0 (make-list 10 #f)))(newline)
