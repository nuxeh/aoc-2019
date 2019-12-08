(use-modules (srfi srfi-1))

(define (build-tree orbits name depth)
  (let ((children (filter (lambda (o) (equal? (car o) name)) orbits)))
    (display children)
    (for-each (lambda (o) (display (second o))(display " ")) children)
    (newline)
    (if (eq? (length children) 0)
        depth
        (fold + 0 (map (lambda (c) (build-tree orbits (second c) (1+ depth))) children)))))

(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits)(newline)
  (display (build-tree orbits "COM" 0)))

