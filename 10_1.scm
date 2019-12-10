(use-modules (ice-9 rdelim)) ;read-line
(use-modules (srfi srfi-1))  ;split-at,map,fold,etc

(define w 0)

;recurse fanning out in both directions from n
(define (detect field len n)
  (if (bitvector-ref field n)
      (begin
        (let ((l (length (detect-dir #t field len n (1- n) '()))))
          (let ((r (length (detect-dir #f field len n (1+ n) '()))))
            (+ l r))))
      0))

(define (unit-vector v)
  (define y (first v))
  (define x (second v))
  (define l (sqrt (+ (* x x) (* y y))))
  (list (/ x l) (/ y l)))

(define (is-new det new acc)
  (define ret acc)
  (define uv1 (unit-vector det))
  (define uv2 (unit-vector new))
  (display acc)(newline)
  (display det)(display "|")(display new)(newline)
  (display uv1)(display "/")(display uv2)(newline)
  (display (- (first uv1) (first uv2)))(newline)
  (display (- (second uv1) (second uv2)))(newline)
  (if (and (< (abs (- (first uv1) (first uv2))) 0.001)
           (< (abs (- (second uv1) (second uv2))) 0.001))
      (begin (display "YES")(newline)
      (set! acc #f)))
  acc)

(define (is-new-dir det off acc)
  (display det)(display "|")
  (display off)(newline)
  (if (or (eq? (second off) 0) (eq? (second det) 0))
      #f
      (begin
        (display (atan (/ (first off) (second off))))(display "|")
        (display (atan (/ (first det) (second det))))(newline)
        (if (eq? (atan (/ (first off) (second off)))
                 (atan (/ (first det) (second det))))
            (set! acc #f))
        ))
  acc)

(define (2d-off off)
  (let ((rows (floor (/ off w))))
    (list rows (- off (* w rows)))))

(define (detect-dir dir field l a n det)
  (define off (- n a))
  (define vec (2d-off off))
  (if (>= n 0)
      (if (< n l)
          (begin
            (if (bitvector-ref field n)
                (let ((new (fold (lambda (d acc) (is-new d vec acc)) #t det)))
                  (display new)(newline)
                  (if new
                    (set! det (append det (list vec))))))
            (display n)(display det)(newline)
            (if dir
                (detect-dir #t field l a (1- n) det)  ;left
                (detect-dir #f field l a (1+ n) det))) ;right
          det)
      det))

(define (to-bit v)
  (if (equal? v #\#)
      #t
      #f))

(define (scan field)
  (define l (bitvector-length field))
  (define detections (make-list l 0))
  (define n 0)
  (map (lambda (d)
         (display "--------")(display n)(newline)
         (let ((d (detect field l n)))
           (set! n (1+ n))
           d))
       detections))

(let ((s ""))
  (do ((c (read-line) (read-line)))
      ((eof-object? c) 'done)
      (set! w (string-length c))
      (set! s (string-append s c)))
  (let ((l (string->list s)))
    (let ((m (list->bitvector (map to-bit l))))
      (display (scan m)))))
