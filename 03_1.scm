(define (get-path cmds p)
  (if (null? (cdr cmds))
    p
    (get-path (cdr cmds) p)))

(define (navigate cmd)
  (if (eq (first cmd))
      (display "up")))

(let ((p1 (read)))
  (let ((p2 (read)))
    (let ((i (string-split (symbol->string p1) #\,)))
    (let ((j (string-split (symbol->string p2) #\,)))
    (display i)
    (newline)
    (display j)
    (newline)
    (let ((p/1 (get-path i (list))))
    (let ((p/2 (get-path j (list))))
      (display p/1)
      (display p/2)
    ))))))


