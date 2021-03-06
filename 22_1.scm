(use-modules (srfi srfi-1))  ;split-at
(use-modules (srfi srfi-11)) ;let-values
(use-modules (ice-9 rdelim)) ;read-line

(define pack-size (string->number (read-line)))
(display (string-append "pack size: " (number->string pack-size) "\n"))

(define (make-pack n c pack)
  (if (< c n)
      (make-pack n (1+ c) (append pack (list c)))
      pack))

(define pack (make-pack pack-size 0 '()))
(define test-pack-len 100)
(define test-pack (make-pack test-pack-len 0 '()))

;deal into new stack
(define (deal-into p)
  (reverse p))

;(display (deal-into test-pack))(newline)

;cut n cards, positive
(define (cut-cards-pos n p)
  (let-values (((head tail) (split-at p n)))
    (append tail head)))

;(display (cut-cards-pos 3 test-pack))(newline)

;cut n cards, negative
(define (cut-cards-neg n p l)
  (let-values (((head tail) (split-at p (- l n))))
    (append tail head)))

;(display (cut-cards-neg 4 test-pack test-pack-len))(newline)

;deal with increment n
(define (deal-with-inc-1 n p l ci res)
  (define cj (floor (modulo (+ ci n) l)))
  (if (null? p)
      res
      (begin
	(list-set! res ci (car p))
	(deal-with-inc-1 n (cdr p) l cj res))))

(define (deal-with-inc n p l)
  (deal-with-inc-1 n p l 0 (make-list l #f)))

;(display (deal-with-inc 3 test-pack test-pack-len))(newline)
;(display (deal-with-inc 3 pack 10007))(newline)

(define cur pack)
(display cur)(newline)

(define (map-ins i)
  (define cur' '())
  (define param (string->number (last i)))
  (if (equal? (car i) "deal")
      (if (equal? (cadr i) "into")
	  (set! cur' (deal-into cur))
	  (set! cur' (deal-with-inc param cur pack-size)))
      (if (> param 0)
	  (set! cur' (cut-cards-pos param cur))
	  (set! cur' (cut-cards-neg (abs param) cur pack-size))))
  (set! cur cur'))

(define instructions '())
(do ((s (read-line) (read-line)))
  ((eof-object? s) 'done)
    (let ((ins (string-split s #\space)))
      (set! instructions (append instructions (list ins)))))

;(display instructions)(newline)
(for-each map-ins instructions)
(display cur)(newline)

(define (find-2019 p pos)
  (if (null? p)
      -1
      (if (eq? (car p) 2019)
	  pos
	  (find-2019 (cdr p) (1+ pos)))))

(display (find-2019 cur 0))(newline) ;part 1
(display (list-ref cur 2020))        ;part 2
