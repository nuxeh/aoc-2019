(use-modules (srfi srfi-1))

;(define (get-path cmds p)
;  (if (null? (car cmds))
;    p
;    ((navigate (car cmds))
;    (display (cdr cmds))
;    (display " ")
;    (get-path (cdr cmds) p))))

(define (navigate cmd pos)
  (let ((x (string->number (string-copy cmd 1))))
    (let ((d (string-copy cmd 0 1)))
      (let ((r (cons 0 0))) 
        (if (string=? d "U")
          (set! r (cons (car pos) (+ (cdr pos) x))))
        (if (string=? d "D")
          (set! r (cons (car pos) (- (cdr pos) x))))
        (if (string=? d "L")
          (set! r (cons (- (car pos) x) (cdr pos))))
        (if (string=? d "R")
          (set! r (cons (+ (car pos) x) (cdr pos))))
        r))))

(define (walk cmd acc)
  (append acc (list (navigate cmd (last acc)))))

(let ((p1 (read)))
  (let ((p2 (read)))
    (let ((i (string-split (symbol->string p1) #\,)))
    (let ((j (string-split (symbol->string p2) #\,)))
    (display i)
    (newline)
    (display j)
    (newline)
    (let ((p/1 (fold walk (list (cons 0 0)) i)))
;    (let ((p/2 (get-path j (list))))
      (display p/1)
;      (display p/2)
    )))))


