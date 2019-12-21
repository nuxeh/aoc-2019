(use-modules (ice-9 rdelim)) ;read-line

(define input '())

;read input
(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (set! input (append input (list (string->list c)))))

(display input)(newline)

(define (is-intersection? line)#t)

;(define (x-intersect lline)
;  (if (not (null? (cadr lline)))
;      (if (and (equal? (car lline) #\#) (equal? (cadr lline) #\#) (equal? (caddr lline) #\#))
;	  (set! (cadr lline) #\#)

(define (y-intersect elems)
  (if (and (eq? (car elems) #\#) (eq? (cadr elems) #\#) (eq? (caddr) #\#))
      (list (car elems) #\* (caddr elems))
      elems))

(define (process-line lines)
  (if (not (null? (caddr lines)))
      (begin
	(map y-intersect (car lines) (cadr lines) (caddr lines))
	(process-line (cadddr lines)))))

(define (display-line line)
  (for-each (lambda (c) (display c)) line)
  (newline))

(process-line input)
(for-each display-line input)
