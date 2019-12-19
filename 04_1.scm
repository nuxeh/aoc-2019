(define start 108457)
(define end 562041)

(define (recurse n found)
  (define z (splitz n))
  (if (<= n end)
      (if (valid z)
	  (recurse (1+ n) (append found (list n)))
	  (recurse (1+ n) found))
      found))

(define (valid z)
  #t)

(define (splitz n)
  (map char->integer (string->list (number->string n))))

(display (splitz 1234567))(newline)

(display (recurse start '()))
(newline)
