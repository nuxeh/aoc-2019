#!/usr/bin/guile -s
!#

(let ((t 0))
(do ((c (read) (read)))
    ((eof-object? c) 'done)
  (let ((x (- (floor (/ c 3)) 2)))
  (+ t x)
  (display x))
  (newline))
(display t))

#!
(let ((x (read)))
  (display (* x x))
  (newline))
!#
