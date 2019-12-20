(use-modules (ice-9 rdelim)) ;read-line

(define (char->bit x)
  (if (equal? x #\#)
      #t
      #f))

(define (process-line y array l)
  (define x 0)
  (let ((d (map char->bit (string->list l))))
    (map (lambda (e) (if e
			 (array-set! array #t x y))
	   (set! x (1+ x))) d)))

(define lines 0)
(define array #f)
(define dim #f)

;read input
(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (let ((wid (string-length c)))
    (if (not dim)
	(set! dim wid))
    (if (not array)
	(set! array (make-array #f wid wid)))
    (process-line lines array c)
    (set! lines (1+ lines))))

(define (scan-y i j d)
  (if (< d 10)
      (if (array-ref array i j)
	  (if (< j (1- dim))
	      (scan-y i (1+ j) (1+ d))
	      #f)
	  #f)
      #t))

(define (scan-x i j d)
  (if (< d 10)
      (if (scan-y i j 0)
	  (if (< i (1- dim))
	      (scan-x (+1 i) j (1+ d))
	      #f)
	  #f)
      #t))

(define (find-10x10 i j)
  (scan-x i j 0))

(define (print-line array i j)
  (if (< i dim)
      (begin
	(if (array-ref array i j)
	    (display #\#)
	    (display #\.))
	(print-line array (1+ i) j))))

(define (array-print array j)
  (if (< j dim)
      (begin
	(print-line array 0 j)
	(newline)
	(array-print array (1+ j)))))

(display (array-index-map! array find-10x10))(newline)
(display (array-dimensions array))(newline)
(array-print array 0)


