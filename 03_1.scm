(use-modules (srfi srfi-1))

;(define (get-path cmds p)
;  (if (null? (car cmds))
;    p
;    ((navigate (car cmds))
;    (display (cdr cmds))
;    (display " ")
;    (get-path (cdr cmds) p))))

(define (navigate cmd acc)
  (display cmd)
  (display " ")
  (let ((pos (last acc)))
    (let ((x (string->number (string-copy cmd 1))))
      (let ((d (string-copy cmd 0 1)))
        (if (string=? d "U")
          (append! acc (list (cons (car pos) (+ (cdr pos) x)))))
        (if (string=? d "D")
          (append! acc (list (cons (car pos) (- (cdr pos) x)))))
        (if (string=? d "L")
          (append! acc (list (cons (- (car pos) x) (cdr pos)))))
        (if (string=? d "R")
          (append! acc (list (cons (+ (car pos) x) (cdr pos)))))
        (display acc)
        (newline)
        acc))))

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
    (let ((p/1 (fold navigate (list (cons 0 0)) i)))
    (let ((p/2 (fold navigate (list (cons 0 0)) j)))
      (display p/1)
      (newline)
      (display p/2)
      (newline)
    ))))))


