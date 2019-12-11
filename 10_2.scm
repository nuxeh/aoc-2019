(use-modules (ice-9 rdelim)) ;read-line
(use-modules (srfi srfi-1))  ;split-at,map,fold,etc

(define w 0)
(define 2pi 6.28318530718)

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

(define (get-vec v2 v1)
  (list (- (first v2) (first v1)) (- (second v2) (second v1))))

(define (check d v res)
  (if (is-line-of-sight v d)
      #t
      res))

(define (detected v det)
  (if (fold (lambda (d r) (check d v r)) #f det)
      det
      (append det (list v))))

(define (det ast alist)
  (define vecs (map (lambda (a) (get-vec ast a)) alist))
  (fold detected '() vecs))

(define (detect asteroids)
  (map (lambda (a) (list a (1- (length (det a asteroids))))) asteroids))

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

(define (dmax l)
    (reduce (lambda (a b)
              (if (> (second a) (second b))
                  a
                  b)) '(0 0) l))

(define (get-angle ast)
  (/ 2pi (atan (first ast) (second ast))))

(define (less l l2)
  (< (first l) (first l2)))

(define (dast a n)
  (display n)(display "\t| ")
  (display (second a))(display ", ")(display (third a))
  (newline))

(define (part/2 station asteroids)
  (define n 0)
  (let ((detection (det station (delete station asteroids))))
    (let ((sort1 (sort-list (map (lambda (d) (cons (get-angle d) d)) detection) less)))
      (let ((sort2 (cons (last sort1) (delete (last sort1) sort1))))
        (display sort2)(newline)
        (for-each (lambda (a) (set! n (1+ n))(dast a n)) sort2))))
  #t)

(let ((s ""))
  (do ((c (read-line) (read-line)))
      ((eof-object? c) 'done)
      (if (> (string-length c) w)
          (set! w (string-length c)))    ;detect input width
      (set! s (string-append s c)))
  (let ((l (string->list s)))            ;get list of characters
    (let ((asts (asteroids l)))          ;get coord for each asteroid
      (display (detect asts))
      (let ((best (dmax (detect asts)))) ;detect and get ast with most detections
        (display (first best))(newline)  ;part 1
        (display (second best))(newline) ;part 1
        (part/2 (first best) asts)))))   ;part 2
