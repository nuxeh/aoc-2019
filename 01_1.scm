#!/usr/bin/guile -s
!#

(do ((c (read) (read)))
    ((eof-object? c) 'done)
  (display c)
  (newline))

#!
(let ((x (read)))
  (display (* x x))
  (newline))
!#
