(define (get-orbits)
  (let ((o '()))
    (do ((l (read) (read)))
      ((eof-object? l) 'done)
      (set! o (append o (list (string-split (symbol->string l) #\|)))))
    o))

(let ((orbits (get-orbits)))
  (display orbits))

