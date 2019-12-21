(use-modules (ice-9 rdelim)) ;read-line
(use-modules (srfi srfi-1))  ;map with different length lists

(define input '())

;read input
(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (set! input (append input (list (string->list c)))))

(define (intersect e f g mark)
  (if (and (eq? e #\#) (not (eq? f #\.)) (eq? g #\#))
      mark
      f))

(define (y-intersect a b c)
  (intersect a b c #\*))

(define (x-intersect a b c)
  (intersect a b c #\0))

(define (xy-intersect a b)
  (if (and (eq? a #\*) (eq? b #\0))
      #\x
      a))

(define (process-line lines res)
  (if (not (null? (caddr lines)))
      (begin
	(let ((r (map y-intersect (car lines) (cadr lines) (caddr lines))))
	  (let ((s (map x-intersect r (cdr r) (cddr r))))
	    (let ((t (map xy-intersect s r)))
	      (process-line (cdr lines) (append res (list r)))))))
      res))

(define (display-line line)
  (for-each (lambda (c) (display c)) line)
  (newline))

(for-each display-line input)

(define input-y (process-line input '()))
(for-each display-line input-y)

(define alignment 0)

(define (x-intersect line x y)
; (display line)(newline)
  (if (not (null? (cddr line)))
      (begin
	(if (and (eq? (car line) #\#) (eq? (cadr line) #\*) (eq? (caddr line) #\#))
	    (begin
	      (set! alignment (+ alignment (* x y)))
	      (display x)(display ", ")
	      (display y)(newline)))
	(x-intersect (cdr line) (1+ x) y))))

(define y 1)
(for-each (lambda (line) (x-intersect line 1 y)(set! y (1+ y))) input-y)
(display alignment)(newline) ;print alignment sum
