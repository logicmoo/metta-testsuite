; Define py-exec to execute Python statements programmatically
(= (py-exec $code)
  (let $exec_fn (py-atom exec)                  ; Bind Python's exec function
    (let $globals (py-atom globals)            ; Bind Python's globals function
      (let $global_ctx ($globals)              ; Retrieve the global context
        (let $_1 ((py-dot $global_ctx __setitem__) "sys" (py-atom "sys")) ; Inject sys into the global context
          ($exec_fn $code $global_ctx))))))  ; Execute the code with the updated global context

; Define py-eval to evaluate Python expressions programmatically
(= (py-eval $code)
  (let $eval_fn (py-atom eval)                  ; Bind Python's eval function
    (let $globals (py-atom globals)            ; Bind Python's globals function
      (let $global_ctx ($globals)              ; Retrieve the global context
        (let $_1 ((py-dot $global_ctx __setitem__) "sys" (py-atom "sys")) ; Inject sys into the global context
          (let $result ($eval_fn $code $global_ctx)  ; Evaluate the code
            (if (== $result ())                    ; Check if the result is empty
              (py-atom "None")                     ; Return Python None
              $result)))))))                       ; Otherwise, return the result

; Define py-leval to evaluate expressions using the local context
(= (py-leval $code)
  (let $eval_fn (py-atom eval)                  ; Bind Python's eval function
    (let $locals_fn (py-atom locals)           ; Bind Python's locals function
      (let $local_ctx ($locals_fn)             ; Retrieve the local context
        (let $_1 ((py-dot $local_ctx __setitem__) "sys" (py-atom "sys")) ; Inject sys into the local context
          (let $result ($eval_fn $code $local_ctx)  ; Evaluate the code with the updated local context
            (if (== $result ())                    ; Check if the result is empty
              (py-atom "None")                     ; Return Python None
              $result)))))))                      ; Otherwise, return the result

; Assertions for py-eval, py-atom, and py-exec
; py-atom might seem prefered
!(test (assertEqual (py-atom "print('hello from py-atom')") (py-atom "None")))
!(test (assertEqual (py-eval "print('hello from py-eval')") (py-eval "None")))
!(test (assertEqual (py-leval "print('hello from py-leval')") (py-leval "None")))
!(test (assertEqual (py-exec "print('hello from py-exec')") ()))

; Test arithmetic operations
!(test (assertEqualToResult (py-atom "1+1") (2)))
!(test (assertEqualToResult (py-eval "1+1") (2)))

!(py-exec "global result_sum; result_sum = 2 + 3")
!(test (assertEqualToResult (py-eval "result_sum") (5)))

; Test string operations
!(py-exec "global result_string; result_string = 'Hello ' + 'World'")
!(test (assertEqualToResult (py-eval "result_string") ("Hello World")))

; Test list operations
!(py-exec "global result_list; result_list = (1, 2, 3) + (4, 5)")
!(test (assertEqual (py-eval "result_list") (py-tuple (1 2 3 4 5))))

; Test dictionary operations
!(py-exec "
global result_dict
result_dict = {'a': 1, 'b': 2}
result_dict['c'] = 3
")
!(test (assertEqual (py-eval "result_dict") (py-dict (("a" 1) ("b" 2) ("c" 3)))))

; Test Python function definition and execution
!(py-exec "
global counter
counter = 0

def increment_counter():
    global counter
    counter += 1
    return counter
")
!(test (assertEqual (py-eval "increment_counter()") 1))
!(test (assertEqual (py-eval "increment_counter()") 2))
!(test (assertEqual (py-eval "counter") 2))

; !(test (assertEqual (py-leval "increment_counter()")  (Error (py-atom "counter") "Exception caught:
; RuntimeError: Failed to find \"counter\"")))


;; py-atom does not see the global scope like this
;!(test (assertEqual (py-atom "increment_counter()")  (Error (py-atom "counter") "Exception caught:
; RuntimeError: Failed to find \"counter\"")))


; Test nested function calls
!(py-exec "
def multiply_and_add(x, y, z):
    return (x * y) + z
")
!(test (assertEqualToResult (py-eval "multiply_and_add(2, 3, 4)") (10)))

