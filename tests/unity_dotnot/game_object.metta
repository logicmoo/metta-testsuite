!(use-module! [library swicli])

; Creating a .NET object using cli_new! and binding it
!(bind! &sb (cli_new! System.Text.StringBuilder ()))
!(println! &sb) ; Print the newly created StringBuilder object

; Invoking methods on the .NET object
!(cli_call! &sb Append "Hello, ")
!(cli_call! &sb Append "MeTTa!")
!(bind! &resultString (cli_call! &sb ToString)) ; Convert StringBuilder to a String
!(println! &resultString) ; Print the result string

; Chaining calls with StringBuilder
!(bind! &finalString 
    (cli_call! 
        (cli_call! (cli_new! System.Text.StringBuilder ()) Append Chained) 
        ToString))
!(println! &finalString) ; Print the final string from chained calls

; Accessing fields (for demonstration, assuming hypothetical public field `Capacity`)
!(bind! &capacity (cli_get! &sb Capacity)) ; Get the value of the field
!(println! &capacity) ; Print the capacity value
!(cli_set! &sb Capacity 100) ; Modify the field (hypothetical example)
!(println! (cli_get! &sb Capacity)) ; Get the modified value of the field

; Using .NET objects in MeTTa logic
!(if (== &resultString "Hello, MeTTa!")
    (println! "The string was built correctly!")
    (println! "There was an issue building the string."))

; Defining a grounded function to interact with .NET objects
!(bind! &append-to-builder 
    (lambda (&builder &text) 
        (cli_call! &builder Append &text)))
!(println! &append-to-builder) ; Print the function definition for debugging

; Using the grounded function
!(&append-to-builder &sb " Another appended string!")
!(bind! &updatedString (cli_call! &sb ToString))
!(println! &updatedString) ; Print the updated string

; Final output
!(println! &updatedString)


;;   See if we cant create unity types
; Load the UnityEngine assembly
!(cli_load_assembly! "UnityEngine")
!(println! "UnityEngine assembly loaded successfully.")

; Creating a Unity Vector3 object using cli_new! and binding it
!(bind! &position (cli_new! UnityEngine.Vector3 (0.0 0.0 0.0)))
!(println! &position) ; Print the newly created Vector3 object

; Creating a Unity GameObject using cli_new! and binding it
!(bind! &gameObject (cli_new! UnityEngine.GameObject ("MyGameObject")))
!(println! &gameObject) ; Print the newly created GameObject

; Setting the position of the GameObject
!(cli_call! &gameObject set_transform_position &position)
!(println! (cli_call! &gameObject get_transform_position)) ; Print the GameObject's position

; Adding a Rigidbody component to the GameObject
!(bind! &rigidbody (cli_call! &gameObject AddComponent UnityEngine.Rigidbody))
!(println! &rigidbody) ; Print the added Rigidbody component

; Applying a force to the Rigidbody
!(cli_call! &rigidbody AddForce (cli_new! UnityEngine.Vector3 (0.0 10.0 0.0)))
!(println! (cli_call! &rigidbody get_velocity)) ; Print the Rigidbody's velocity

; Using Unity objects in MeTTa logic
!(if (== (cli_call! &gameObject get_name) "MyGameObject")
    (println! "The GameObject was created and named correctly!")
    (println! "There was an issue with the GameObject's creation."))

; Defining a grounded function to move a GameObject
!(bind! &move-game-object 
    (lambda (&obj &newPosition) 
        (cli_call! &obj set_transform_position &newPosition)))
!(println! &move-game-object) ; Print the function definition for debugging

; Using the grounded function to move the GameObject
!(bind! &newPosition (cli_new! UnityEngine.Vector3 (5.0 5.0 5.0)))
!(&move-game-object &gameObject &newPosition)
!(println! (cli_call! &gameObject get_transform_position)) ; Print the updated position

; Final output
!(println! "Unity object manipulation complete.")

