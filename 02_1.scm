(use-modules (srfi srfi-1))
(use-modules (srfi srfi-11))

;(define (get-sublist l s f)
;  (list-head (list-tail l 4) f))

;(define (recurse l p r) #t)

(define target 19690720)

; +
(define (one l i)
  (list-set! l (fourth i) (+ (list-ref l (second i)) (list-ref l (third i))))
  l)

; *
(define (two l i)
  (list-set! l (fourth i) (* (list-ref l (second i)) (list-ref l (third i))))
  l)

(define ops (list one two))

(define (exec l ins)
  (if (= (first ins) 1)
      (one l ins)
      (if (= (first ins) 2)
          (two l ins)
          (if (= (first ins) 99)
              l))))

(define (run l pc)
  (let ((ins (get-ins l pc 0)))
    (if (list? ins)
        (let ((l2 (exec l ins)))
          (run l2 (+ pc 1)))
        l)))

; recurse tails until instruction count reached
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

(define (find-target-inputs i t)
  (do ((n 0 (1+ n))) ((> n 99))
    (do ((v 0 (1+ v))) ((> v 99))
      (let ((j (list-copy i)))
        (list-set! j 1 n)
        (list-set! j 2 v)
;       (newline)
        (let ((res (run j 0)))
;         (display res)(display " -> ")(display (first res))
          (if (= (first res) t)
              ((display "> ")(display n)(display ", ")(display v))))))))

(let ((x (read)))
  (let ((i (map string->number (string-split (symbol->string x) #\,))))
    (display i)
    (newline)
    (display (get-ins i 0 0))
    (display (get-ins i 1 0))
    (display (get-ins i 2 0))
    (display (get-ins i 3 0))
    (newline)
    (let ((j (list-copy i)))
      (let ((r (run j 0)))
  (display r)
  (newline)
  (display (first r))))
    (let ((j (list-copy i)))
      (newline)
      (find-target-inputs j target))))

    
;    (do ((j 0 (1+ j)))
;        (let ((c (get-ins i j 0))) ((list? c))
;   (display c)
;   (newline)))))
