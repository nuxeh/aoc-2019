(use-modules (srfi srfi-1))

(define (build-tree orbs name d)
  (let ((cs (filter (lambda (o) (equal? (car o) name)) orbs)))
    (display cs)
    (for-each (lambda (o) (display (second o))(display " ")) cs)
    (newline)
    (if (eq? (length cs) 0)
        d
        (fold + 0 (map (lambda (c) (build-tree orbs (second c) (1+ d))) cs)))))

(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits)(newline)
  (display (build-tree orbits "COM" 0)))

