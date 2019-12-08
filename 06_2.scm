(use-modules (srfi srfi-1))

(define (build-tree orbs name d)
  (let ((cs (filter (lambda (o) (equal? (second o) name)) orbs)))
    (display name)(newline)
    (if (equal? name "SAN")
        (display (string-append "SAN: " (number->string d) "\n")) )
    (if (equal? name "YOU")
        (display (string-append "YOU: " (number->string d) "\n")) )
    (if (eq? (length cs) 0)
        d
        (fold + d (map (lambda (c) (build-tree orbs (first c) (1+ d))) cs)))))

(define (get-inter-santa-dist orbs)
  (build-tree orbs "SAN" 0)
  (build-tree orbs "YOU" 0))

(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits)(newline)
  (display (get-inter-santa-dist orbits))) ;part 2

