(use-modules (srfi srfi-1))

(define (build-tree orbs name d)
  (let ((cs (filter (lambda (o) (equal? (car o) name)) orbs)))
    (if (equal? name "SAN")
        (display (string-append "SAN: " (number->string d) "\n")) )
    (if (equal? name "YOU")
        (display (string-append "YOU: " (number->string d) "\n")) )
    (if (eq? (length cs) 0)
        d
        (fold + d (map (lambda (c) (build-tree orbs (second c) (1+ d))) cs)))))

(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits)(newline)
  (display (build-tree orbits "COM" 0)))

