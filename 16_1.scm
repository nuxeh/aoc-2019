(use-modules (ice-9 rdelim)) ;read-line
(use-modules (srfi srfi-1))  ;differing length map

(define in (map (lambda (v) (- v 48)) (map char->integer (string->list (read-line)))))
(define l (length in))
(display in)(newline)
(display l)(newline)

(define cycle '(0 1 0 -1))

#!
0  1  0 -1  0  1  0 -1  0  1  0 -1

0  0  1  1  0  0 -1 -1  0  0  1  1

0  0  0  1  1  1  0  0  0 -1 -1 -1

0  0  0  0  1  1  1  1  0  0  0  0
!#

(define (gen-phase n l len step res)
  (define step' (floor (modulo (1+ step) 4)))
  (if (<= len l)
      (begin
	(gen-phase n l (+ len n) step' (append res (make-list n (list-ref cycle step)))))
      (cdr res)))

(define (gen-phases input)
  (define p 0)
  (map (lambda (_) (set! p (1+ p))(gen-phase p l 0 0 '())) input))

(define phases (gen-phases in))
(display phases)(newline)

(define (get-digit n)
  (- n (* 10 (floor (/ n 10)))))

(define (proc ph i)
  (get-digit (abs (fold (lambda (q j a) (+ a (* q j))) 0 i ph))))

(define (calc-phase phss input)
  (map (lambda (p) (proc p input)) phss))

(display (calc-phase phases in))
