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

(define (checksum imgdata w h res)
  (let-values (((head tail) (split-at imgdata (* w h))))
    (let ((n0 (fold (lambda (p a) (count-n 0 p a)) 0 head)))
      (let ((n1 (fold (lambda (p a) (count-n 1 p a)) 0 head)))
        (let ((n2 (fold (lambda (p a) (count-n 2 p a)) 0 head)))
          (set! res (append res (list (list n0 (* n1 n2))))))))
    (if (null? tail)
        res
        (checksum tail w h res))))

(define (char->number a)
  (string->number (string a)))

(define (smallest-sum r acc)
  (if (null? acc)
      r
      (if (< (first r) (first acc))
          r
          acc)))

(define (get-layers imgdata w h res)
  (let-values (((head tail) (split-at imgdata (* w h))))
    (set! res (append res (list head)))
    (if (null? tail)
        res
        (get-layers tail w h res))))

(define (pixel-superimpose pxls)
  (display pxls)(newline)
  (first pxls))

(define (layer-combine layer pr)
  (map pixel-superimpose (zip layer pr)))

(define (image-display imgdata w h)#t)

;get input and run
(let ((idata (map char->number (string->list (read)))))
  (let ((csums (checksum idata w h '())))
    (display (fold smallest-sum '() csums))(newline)) ;part 1
  (let ((layers (get-layers idata w h '())))
    (display layers)(newline)
    (let ((img (fold-right layer-combine (make-list (* w h) 0) layers)))
      (display img))))
