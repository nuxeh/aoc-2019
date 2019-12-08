(use-modules (srfi srfi-1))

; recurse backwards from node
(define (build-tree orbs name d)
  (let ((cs (filter (lambda (o) (equal? (second o) name)) orbs)))
    (if (eq? (length cs) 0)
        d
        (let ((p (first cs)))
          (build-tree orbs (first p) (append d (list name)))))))

(define (get-inter-santa-dist orbs)
  (define s (build-tree orbs "SAN" '()))
  (define y (build-tree orbs "YOU" '()))
  (define com (filter (lambda (o) (member o s)) y))
  (define sx (list-index (lambda (o) (equal? o (first com))) s))
  (define yx (list-index (lambda (o) (equal? o (first com))) y))
  (display s)(newline)(display y)(newline)
  (display "common: ")(display com)(newline)
  (display "santa's steps: ")(display sx)(newline)
  (display "your steps: ")(display yx)(newline)
  (display (- (+ sx yx) 2)))

(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits)(newline)
  (get-inter-santa-dist orbits)) ;part 2

