#!/usr/bin/guile -s
!#

(define fuel
  (lambda (mass)
    ((- (floor (/ mass 3)) 2))))

(define (fuel2 m)
  (display m)
  (newline)
  ((- (floor (/ m 3)) 2)))

(define (foo n)
  (foo (1+ n)))

(let ((t 0))
(do ((c (read) (read)))
    ((eof-object? c) 'done)
  (let ((x (fuel2 c)))
  (set! t (+ t x))
  (display x))
  (newline))
(display t))
