#!/usr/bin/guile -s
!#

(define (fuel m)
  (display m)
  (newline)
  (- (floor (/ m 3)) 2))

(define (foo n)
  (foo (1+ n)))

(let ((t 0))
(do ((c (read) (read)))
    ((eof-object? c) 'done)
  (set! t (+ t (fuel c)))
(display t)))
