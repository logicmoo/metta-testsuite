

(= (get-single-char)
  (let $tty (py-atom tty)                     ; Bind tty module locally
  (let $sys (py-atom sys)                     ; Bind sys module locally
  (let $termios (py-atom termios)             ; Bind termios module locally
  (let $stdin (py-dot $sys stdin)             ; Access sys.stdin
  (let $fd ((py-dot $stdin fileno))           ; Call stdin.fileno()
  (let $old_settings ((py-dot $termios tcgetattr) $fd) ; Save original terminal settings
  (let $_1 ((py-dot $tty setraw) $fd)         ; Set terminal to raw mode
  (let $char ((py-dot $stdin read) 1)         ; Read a single character		
  (let $_2 ((py-dot $termios tcgetattr) $fd)  ; Get current settings after setraw
  (let $_3 ((py-dot $termios tcflag_enable) $_2 (py-dot $termios ICANON)) ; Re-enable canonical mode
  (let $_4 ((py-dot $termios tcflag_enable) $_3 (py-dot $termios ECHO)) ; Re-enable echo mode
  (let $_5 ((py-dot $termios tcsetattr) $fd ((py-dot $termios TCSADRAIN)) $_4) ; Apply restored settings
  (let $os (py-atom os)                      ; Bind the os module locally
  (let $_6 ((py-dot $os system) "stty sane") ; Run the stty sane command
    $char)))))))))))))))
; called with 
;  !(get-single-char)


