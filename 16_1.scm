(use-modules (ice-9 rdelim)) ;read-line

(define in (map (lambda (v) (- v 48)) (map char->integer (string->list (read-line)))))
(display in)(newline)
(display (length in))



(define (gen-phase p len cp cv res)
  (if (<= cp p)
      (gen-phase (1+ p) nv res)
      (cdr res))
