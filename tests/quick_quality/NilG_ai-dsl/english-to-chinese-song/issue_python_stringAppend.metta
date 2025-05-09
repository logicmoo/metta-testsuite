;;;;;;;;;;
; String ;
;;;;;;;;;;

;; The purpose of this code is to define a function to concatenate two strings
;; using Python's string addition method.

;; Define a function type for String.append which concatenates two strings
(: String.append (-> String String String))

;; Implement the String.append function using Python's __add__ method for strings
(= (String.append $x $y) 
   ((py-dot $x __add__ (-> String String String)) $y))

;; Bind the Python string addition method to abcPlus for the string "abc"
!(bind! abcPlus (py-dot "abc" __add__))


;!(let $f abcPlus (with-debug e (rtrace!  ($f "def"))))

;!(repl!)

;!(with-debug e (rtrace!  (abcPlus "def")))

;; Assert that using abcPlus to add "def" to "abc" equals "abcdef"
!(assertEqual (abcPlus "def") "abcdef")

;!(assertEqual (rtrace! ((py-dot "abc" __add__) "def")) "abcdef")

;; Directly use Python's __add__ method to add "def" to "abc" and assert the result is "abcdef"
!(assertEqual ((py-dot "abc" __add__ (-> String String String)) "def") "abcdef")

;; Test String.append
!(assertEqual (String.append "abc" "def") "abcdef")
!(assertEqual (String.append "\"" "\"") "\"\"")
!(assertEqual (String.append "\"" (String.append "\"" "\"")) "\"\"\"")
!(assertEqual (String.append (String.append "abc" "def") (String.append "g" "hij")) "abcdefghij")

;; Overload String.append to support more than 2 arguments
(: String.append3 (-> String String String String))
(= (String.append3 $x $y $z) (String.append $x (String.append $y $z)))
(: String.append4 (-> String String String String String))
(= (String.append4 $x $y $z $w) (String.append $x (String.append3 $y $z $w)))
(: String.append5 (-> String String String String String String))
(= (String.append5 $x $y $z $w $s) (String.append $x (String.append4 $y $z $w $s)))

;; Join a list of string by a separator
(: String.join (-> String (List String) String))
(= (String.join $separator Nil) "")
(= (String.join $separator (Cons $head $tail))
   (case $tail
     ((Nil $head)
      ($else (String.append3 $head $separator (String.join $separator $tail))))))

;; Test String.join
!(assertEqual (String.join ", " (Cons "x=42" (Cons "y=24" Nil))) "x=42, y=24")

