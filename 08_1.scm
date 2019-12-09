(use-modules (srfi srfi-1))  ;split-at,map,fold,etc
(use-modules (srfi srfi-11)) ;let-values

(define w (read))
(define h (read))
(display (string-append "w: " (number->string w) "\n"))
(display (string-append "h: " (number->string h) "\n"))

(define (count-n n p acc)
  (if (eq? p n)
      (+ acc 1)
      acc))

(define (image-chunk imgdata w h res)
  (let-values (((head tail) (split-at imgdata (* w h))))
    (let ((n0 (fold (lambda (p a) (count-n 0 p a)) 0 head)))
      (let ((n1 (fold (lambda (p a) (count-n 1 p a)) 0 head)))
        (let ((n2 (fold (lambda (p a) (count-n 2 p a)) 0 head)))
          (set! res (append res (list (list n0 (* n1 n2))))))))
    (if (null? tail)
        res
        (image-chunk tail w h res))))

(define (char->number a)
  (string->number (string a)))

(define (smallest-sum r acc)
  (if (null? acc)
      r
      (if (< (first r) (first acc))
          r
          acc)))

(let ((idata (map char->number (string->list (number->string (read ))))))
  (let ((csums (image-chunk idata w h '())))
    (display (fold smallest-sum '() csums))))
