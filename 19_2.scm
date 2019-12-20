(use-modules (ice-9 rdelim)) ;read-line

(define (char->bit x)
  (if (equal? x #\#)
      #t
      #f))

(define (process-line y array l)
  (define x 0)
  (let ((d (map char->bit (string->list l))))
    (display d)(newline)
    (map (lambda (e) (if e
			 (array-set! array #t x y))
	   (set! x (1+ x))) d)))

(define lines 0)
(define array #f)

;read input
(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (let ((dim (string-length c)))
    (if (not array)
	(set! array (make-array #f dim dim)))
    (process-line lines array c)
    (set! lines (1+ lines))))

(display array)(newline)

(define (scan-y i j)#t)

(define (scan-x i j)#t)

(define (find-10x10 i j)
  (display (array-ref array i j))(newline))

(display (array-index-map! array find-10x10))(newline)
