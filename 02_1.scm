(let ((x (read)))
  (display (string-split (symbol->string x) #\,))
  (newline))
