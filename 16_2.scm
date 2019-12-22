(use-modules (ice-9 rdelim)) ;read-line

(define in (read-line))

(do ((i 1 (1+ i))) ((> i 10000))
  (display in))
(newline)
