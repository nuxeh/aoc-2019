(define start 108457)
(define end 562041)

(define (recurse n found)
  (define z (splitz n))
  (if (<= n end)
      (if (valid? z)
	  (recurse (1+ n) (append found (list n)))
	  (recurse (1+ n) found))
      found))

(define (valid? z)
  (and (ascends? z) (contains-double? z)))

(define (contains-double? z)
  (if (null? (cdr z))
      #f
      (if (equal? (car z) (car (cdr z)))
	  (if (null? (cdr (cdr z)))
	      #t
	      (if (equal? (car z) (car (cddr z)))
		  (if (null? (cdddr z))
		      #f
		      (if (null? (cddddr z))
			  (if (equal? (car z) (cddd
		      (contains-double? (cdddr z)))
		  #t))
	  (contains-double? (cdr z)))))

(define (ascends? z)
  (if (null? (cdr z))
      #t
      (if (<= (car z) (car (cdr z)))
	  (ascends? (cdr z))
	  #f)))

(define (splitz n)
  (map char->integer (string->list (number->string n))))

(display (ascends? '(1 2 3 4 5 6)))(newline)
(display (ascends? '(1 2 3 7 5 6)))(newline)
(display (contains-double? '(1 2 3 7 5 6)))(newline)
(display (contains-double? '(1 2 3 5 5 6)))(newline)

(display (splitz 1234567))(newline)

(define result (recurse start '()))
(display result)
(newline)
(display (length result))
(newline)
