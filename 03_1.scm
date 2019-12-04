(let ((p1 (read)))
  (let ((p2 (read)))
    (let ((i (string-split (symbol->string p1) #\,)))
    (let ((j (string-split (symbol->string p2) #\,)))
    (display i)
    (newline)
    (display j)
    (newline)))))

