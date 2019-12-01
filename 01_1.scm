#!/usr/bin/guile -s
!#

(do ((c (read) (read)))
    ((eof-object? c) 'done)
  (let ((x (- (floor (/ c 3)) 2)))
  (display x))
  (newline))

#!
(let ((x (read)))
  (display (* x x))
  (newline))
!#
