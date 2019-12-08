(use-modules (srfi srfi-1))

;recurse backwards from node
(define (build-tree orbs name d)
  (let ((cs (filter (lambda (o) (equal? (second o) name)) orbs)))
    (display name)(newline)
    (display cs)(newline)
    (display d)(newline)
    (if (eq? (length cs) 0)
        d
        (map (lambda (c) (build-tree orbs (first c) (append d (list name)))) cs))))

(define (get-inter-santa-dist orbs)
  (display (build-tree orbs "SAN" '()))
  (map display (build-tree orbs "YOU" '())))

(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits)(newline)
  (get-inter-santa-dist orbits)) ;part 2

