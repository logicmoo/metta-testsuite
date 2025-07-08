;; ----------------------------------------
;; Display the board in a formatted grid
;; ----------------------------------------

!(println! "hi")

(= (display-board $Nine)
  (println! (format-args "\n{}\n
	   {} | {} | {}
	  -----------
	   {} | {} | {}
	  -----------
	   {} | {} | {}

\n" $Nine)))

!(display-board ("board" X X X 4 5 6 O O O))

!(repl!)
