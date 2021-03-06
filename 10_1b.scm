(use-modules (ice-9 rdelim)) ;read-line
(use-modules (srfi srfi-1))  ;split-at,map,fold,etc

(define w 0)

(define (unit-vector v)
  (define y (first v))
  (define x (second v))
  (define l (sqrt (+ (* x x) (* y y))))
  (if (eq? l 0)
      (list 0 0)
      (list (/ x l) (/ y l))))

(define (is-line-of-sight a1 a2)
  (define uv1 (unit-vector a1))
  (define uv2 (unit-vector a2))
  (and (< (abs (- (first uv1) (first uv2))) 0.00001)
       (< (abs (- (second uv1) (second uv2))) 0.00001)))

(define (get-vec v1 v2)
  (list (- (first v1) (first v2)) (- (second v1) (second v2))))

(define (check d v res)
  (if (is-line-of-sight v d)
      #t
      res))

(define (detected v det)
  (if (fold (lambda (d r) (check d v r)) #f det)
      det
      (append det (list v))))

(define (det ast alist)
  (define det '())
  (define vecs (map (lambda (a) (get-vec ast a)) alist))
  ;(display vecs)(newline)
  (1- (length (fold detected '() vecs))))

(define (detect asteroids)
  (map (lambda (a) (det a asteroids)) asteroids))

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
      (if (> (string-length c) w)
          (set! w (string-length c)))
      (set! s (string-append s c)))
  (let ((l (string->list s)))
    (display (reduce max 0 (detect (asteroids l))))))
