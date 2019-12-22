(use-modules (ice-9 rdelim)) ;read-line

(define in (map (lambda (v) (- v 48)) (map char->integer (string->list (read-line)))))
(display in)
