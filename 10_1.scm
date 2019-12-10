(use-modules (ice-9 rdelim)) ;read-line
(use-modules (srfi srfi-1))  ;split-at,map,fold,etc

;recurse fanning out in both directions from n
(define (detect field len n)
  (if (bitvector-ref field n)
      (begin
        (let ((l (length (detect-dir #t field len n (1- n) '()))))
          (let ((r (length (detect-dir #f field len n (1+ n) '()))))
            (+ l r))))
      0))

(define (is-new det off acc)
  (display det)(newline)
  (display off)(newline)
  (if (eq? 0 (modulo off det))
      (set! acc #f))
  acc)

(define (detect-dir dir field l a n det)
  (define offset (abs (- a n)))
  (if (>= n 0)
      (if (< n l)
          (begin
            (if (bitvector-ref field n)
                (if (fold (lambda (d acc) (is-new d offset acc)) #t det)
                    (set! det (append det (list offset)))))
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
      (set! s (string-append s c)))
  (let ((l (string->list s)))
    (let ((m (list->bitvector (map to-bit l))))
      (display (scan m)))))
