(use-modules (srfi srfi-1))
(use-modules (srfi srfi-11))

;(define (get-sublist l s f)
;  (list-head (list-tail l 4) f))

;(define (recurse l p r) #t)

(define (one l i) #t
  )

(define (two l i) #t
  )

(define (exec l ins)
  (if ((= (first ins) 1))
    (one l ins)
    (if ((= (first ins) 2))
      (two l ins)))
  )

(define (run l pc)
  (let ((ins (get-ins l pc 0)))
    (if (list? ins)
      (exec l ins)
      l)))

(define (get-ins l n c)
  (let-values (((head tail) (split-at l 4)))
    ;(newline)
    ;(display c)
    ;(display head)
    ;(display tail)
    (if (< c n)
	(if (>= (length tail) 4)
          (get-ins tail n (+ c 1))
	  #f)
      head)))

(let ((x (read)))
  (let ((i (map string->number (string-split (symbol->string x) #\,))))
    (display i)
    (newline)
    (display (get-ins i 0 0))
    (display (get-ins i 1 0))
    (display (get-ins i 2 0))
    (display (get-ins i 3 0))
    (display (run i 0))))

    
;    (do ((j 0 (1+ j)))
;        (let ((c (get-ins i j 0))) ((list? c))
;	  (display c)
;	  (newline)))))
