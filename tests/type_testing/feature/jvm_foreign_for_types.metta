!(use-module! [library jpl])

; Creating a Java object using jpl_new! and binding it
!(bind! &sb (jpl_new! java.lang.StringBuilder ()))
!(println! &sb) ; Print the newly created StringBuilder object

; Invoking methods on the Java object
!(jpl_call! &sb "append" "Hello, ")
!(jpl_call! &sb "append" "MeTTa!")
!(bind! &resultString (jpl_call! &sb toString)) ; Convert StringBuilder to a String
!(println! &resultString) ; Print the result string

; Chaining calls with StringBuilder
!(bind! &finalString 
    (jpl_call! 
        (jpl_call! (jpl_new! java.lang.StringBuilder ()) append Chained ) 
        toString))
!(println! &finalString) ; Print the final string from chained calls

; Accessing fields (for demonstration, assuming hypothetical public field `capacity`)
!(bind! &capacity (jpl_get! &sb capacity)) ; Get the value of the field
!(println! &capacity) ; Print the capacity value
!(jpl_set! &sb capacity 100) ; Modify the field (hypothetical example)
!(println! (jpl_get! &sb capacity)) ; Get the value of the field

; Using Java objects in MeTTa logic
!(if (== &resultString "Hello, MeTTa!")
    (println! "The string was built correctly!")
    (println! "There was an issue building the string."))

; Defining a grounded function to interact with Java objects
!(bind! &append-to-builder 
    (lambda (&builder &text) 
        (jpl_call! &builder append &text)))
!(println! &append-to-builder) ; Print the function definition for debugging

; Using the grounded function
!(&append-to-builder &sb " Another appended string!")
!(bind! &updatedString (jpl_call! &sb toString))
!(println! &updatedString) ; Print the updated string

; Final output
!(println! &updatedString)

