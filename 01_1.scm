#!/usr/bin/guile -s
!#

(do ((c (read-char) (read-char)))
    ((eof-object? c) 'done)
  (display c))

#!
(let ((x (read)))
  (display (* x x))
  (newline))
!#
