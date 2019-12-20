(use-modules (ice-9 rdelim)) ;read-line

(define (char->bit x)
  (if (equal? x #\#)
      #t
      #f))

(define (process-line y array l)
  (define x 0)
  (let ((d (map char->bit (string->list l))))
    (map (lambda (e) (if e
			 (begin
			   (array-set! array #t x y)
			   (array-set! tractor #t x y)))
	   (set! x (1+ x))) d)))

(define santa-width 100)
(define lines 0)
(define array #f)
(define tractor #f)
(define dim #f)

;read input
(do ((c (read-line) (read-line)))
  ((eof-object? c) 'done)
  (let ((wid (string-length c)))
    (if (not dim)
	(set! dim wid))
    (if (not array)
	(set! array (make-array #f wid wid)))
    (if (not tractor)
	(set! tractor (make-array #f wid wid)))
    (process-line lines array c)
    (set! lines (1+ lines))))

(define (scan-y i j d)
  (if (<= d santa-width)
      (if (array-ref array i j)
	  (if (< j (1- dim))
	      (scan-y i (1+ j) (1+ d))
	      #f)
	  #f)
      #t))

(define (scan-x i j d)
  (if (<= d santa-width)
      (if (scan-y i j 0)
	  (if (< i (1- dim))
	      (scan-x (1+ i) j (1+ d))
	      #f)
	  #f)
      #t))

(define found #f)

(define (find-region i j)
  (if (not found)
      (if (scan-x i j 0)
	  (set! found (+ (* i 10000) j)))))

(define (print-line array i j)
  (if (< i dim)
      (begin
	(if (array-ref array i j)
	    (display #\#)
	    (if (array-ref tractor i j)
		(display #\~)
		(display #\.)))
	(print-line array (1+ i) j))))

(define (array-print array j)
  (if (< j dim)
      (begin
	(print-line array 0 j)
	(newline)
	(array-print array (1+ j)))))

(define hits '())

(array-index-map! array find-region) ;find 10x10 filled areas
(display (array-dimensions array))(newline)
;(array-print array 0)

(define (get-hits i j)
  (if (array-ref array i j)
      (set! hits (append hits (list (+ (* i 10000) j))))))

;(array-index-map! array get-hits) ;convert to coordinates
;(display hits)(newline)
(display found)(newline)
