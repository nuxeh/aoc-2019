#!/usr/bin/guile -s
!#

(define (fuel r t)
  (display (string-append (number->string r) " "))
  (let ((f (- (floor (/ r 3)) 2)))
    (let ((s (- r f)))
      (let ((t (+ t f)))
        (fuel f t)))))

(let ((t 0))
(do ((c (read) (read)))
    ((eof-object? c) 'done)
  (set! t (+ t (fuel c 0)))
(display t)))
