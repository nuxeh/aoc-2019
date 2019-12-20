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

(define (scan-y i j d)
  (if (array-ref array i j)
      (if (< d 10)
	  (scan-y i (1+ j) (1 +d))
	  #t)
      #f))

(define (scan-x i j d)
  (if (array-ref array i j)
      (if (scan-y i j 0)
	  (scan-x (+1 i) j (1+ d))
	  #f)
      #f))

(define (find-10x10 i j)
  (scan-x i j 0))

(display (array-index-map! array find-10x10))(newline)
