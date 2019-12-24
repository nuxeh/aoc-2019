#!/usr/bin/guile -s
!#

(use-modules (ice-9 rdelim)) ;read-line

(define result '())
(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (set! result  (append result (list (string->list c)))))
(write result)(newline)
