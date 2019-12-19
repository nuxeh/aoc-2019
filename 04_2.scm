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
      #t
      (contains-double? (cdr z))))

(define (count-nums z alist)
  (if (null? z)
      alist
      (let ((count (assoc (car z) alist)))
	(if count
	    (count-nums (cdr z) (acons (car z) (1+ (cdr count)) alist))
	    (count-nums (cdr z) (acons (car z) 1 alist))))))

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
(display (valid? '(1 1 1 1 1 2)))(newline)
(display (count-nums '(1 1 1 1 1 2) '()))(newline)

(display (splitz 1234567))(newline)

(define result (recurse start '()))
(display result)
(newline)
(display (length result))
(newline)
