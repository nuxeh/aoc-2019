(use-modules (ice-9 rdelim)) ;read-line

(define input '())

;read input
(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (set! input (append input (list (string->list c)))))

(define (is-intersection? line)#t)

;(define (x-intersect lline)
;  (if (not (null? (cadr lline)))
;      (if (and (equal? (car lline) #\#) (equal? (cadr lline) #\#) (equal? (caddr lline) #\#))
;	  (set! (cadr lline) #\#)

(define (y-intersect e f g)
  (if (and (eq? e #\#) (eq? f #\#) (eq? g #\#))
      #\*
      f))

(define (process-line lines res)
  (if (not (null? (caddr lines)))
      (begin
	(let ((r (map y-intersect (car lines) (cadr lines) (caddr lines))))
	  (process-line (cdr lines) (append res (list r)))))
      res))

(define (display-line line)
  (for-each (lambda (c) (display c)) line)
  (newline))

(for-each display-line input)
(for-each display-line (process-line input '()))
