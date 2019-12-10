(use-modules (ice-9 rdelim)) ;read-line
(use-modules (srfi srfi-1))  ;split-at,map,fold,etc

(define w 0)

(define (find-asteroids c acc n)
  (define x (modulo n w))
  (define y (floor (/ n w)))
  (if (equal? c #\#)
      (append acc (list (list x y)))
      acc))

(define (asteroids l)
  (define n 0)
  (fold (lambda (cell acc)
          (let ((a (find-asteroids cell acc n)))
            (set! n (1+ n))
            a)) '() l))

(let ((s ""))
  (do ((c (read-line) (read-line)))
      ((eof-object? c) 'done)
      (set! w (string-length c))
      (set! s (string-append s c)))
  (let ((l (string->list s)))
    (display (asteroids l))))
