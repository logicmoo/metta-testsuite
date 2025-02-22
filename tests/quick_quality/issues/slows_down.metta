
(= (nth $n $list) 
    (if (== $n 1)
        (car-atom $list)
        (nth (- $n 1) (cdr-atom $list)))) ; Recursion: move to the next element (cdr-atom) and decrease n.

; replace_square_recursive
;   Function:  Move one piece to new location  on board, return the new board. 
;   input: X1, Y1, color, rank, X2, Y2, board
;   output:  new board which overwrites X2 and Y2 with new piece and removes color  and rank from X1 and Y1
(: (replace_square_recursive) (-> Atom Atom Atom Atom Atom Atom Expression Expression))
(= (replace_square_recursive $X1 $Y1 $color $rank $X2 $Y2 $current_board) 
   (if (== (size-atom $current_board) 0)
        ()
        (let* (
          ($next-sq (car-atom $current_board))
          ($X (nth 1 $next-sq))
          ($Y (nth 2 $next-sq))
              )
        (if (and (== $X $X1) (== $Y $Y1))
          ; if we are on the square being moved FROM, then remove piece color and rank since it will disappear
          (let $from_square ($X1 $Y1)   ; <-- note no color and rank
               (let $rest (replace_square_recursive $X1 $Y1 $color $rank $X2 $Y2 (cdr-atom $current_board)) 
                          (cons-atom $from_square $rest)))
        (if (and (== $X $X2) (== $Y $Y2))
          ; elif on square being moved INTO, use the moving piece's color and rank.
          (let $into_square ($X2 $Y2 $color $rank)  ; <-- color and rank in destination
               (let $rest (replace_square_recursive $X1 $Y1 $color $rank $X2 $Y2 (cdr-atom $current_board)) 
                          (cons-atom $into_square $rest)))
          ; otherwise just keep chugging through the board...
        (let $rest (replace_square_recursive $X1 $Y1 $color $rank $X2 $Y2 (cdr-atom $current_board)) 
                          (cons-atom $next-sq $rest)))))))  ; <-- here we just copy the existing square

!(println! "starting...")
!(replace_square_recursive 1 8 g r 4 4
                       ((1 8 g r) (2 8 g n) (3 8 g b) (4 8 g q) (5 8 g k) (6 8 g b) (7 8 g n) (8 8 g r) 
                        (1 7 g p) (2 7 g p) (3 7 g p) (4 7 g p) (5 7 g p) (6 7 g p) (7 7 g p) (8 7 g p) 
                        (1 6) (2 6) (3 6) (4 6) (5 6) (6 6) (7 6) (8 6) 
                        (1 5) (2 5) (3 5) (4 5) (5 5) (6 5) (7 5) (8 5) 
                        (1 4) (2 4) (3 4) (4 4) (5 4) (6 4) (7 4) (8 4) 
                        (1 3) (2 3) (3 3) (4 3) (5 3) (6 3) (7 3) (8 3) 
                        (1 2 s p) (2 2 s p) (3 2 s p) (4 2 s p) (5 2 s p) (6 2 s p) (7 2 s p) (8 2 s p) 
                        (1 1 s r) (2 1 s n) (3 1 s b) (4 1 s q) (5 1 s k) (6 1 s b) (7 1 s n) (8 1 s r)))


