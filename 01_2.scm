#!/usr/bin/guile -s
!#

(define (fuel r t)
  (display (string-append " " (number->string r) " "))
  (let ((f (- (floor (/ r 3)) 2)))
    (let ((u (+ t f)))
      (if (> f 0) 
        (fuel f u)
	t))))

(let ((t 0))
(do ((c (read) (read)))
    ((eof-object? c) 'done)
  (let ((f (fuel c 0)))
  (set! t (+ t f))
  (display (string-append "= " (number->string f))))
  (newline)
(display t)))
