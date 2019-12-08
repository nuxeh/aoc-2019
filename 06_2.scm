(use-modules (srfi srfi-1))

(define (build-tree orbs name d)
  (let ((cs (filter (lambda (o) (equal? (second o) name)) orbs)))
    (display name)(newline)
    (if (eq? (length cs) 0)
        d
        (map (lambda (c) (build-tree orbs (first c) (append d (list name)))) cs))))

(define (get-inter-santa-dist orbs)
  (build-tree orbs "SAN" '())
  (build-tree orbs "YOU" '()))

(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits)(newline)
  (display (get-inter-santa-dist orbits))) ;part 2

