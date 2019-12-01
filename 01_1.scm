#!/usr/bin/guile -s
!#

(do ((c (read) (read)))
    ((eof-object? c) 'done)
  (display (- (floor (/ c 3)) 2))
  (newline))

#!
(let ((x (read)))
  (display (* x x))
  (newline))
!#
