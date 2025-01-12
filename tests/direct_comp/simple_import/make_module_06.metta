; Bind Python's core functions and modules using py-atom
!(bind! types_module (py-atom "types.ModuleType"))         ; Access types.ModuleType
!(bind! sys_modules (py-atom "sys.modules"))               ; Access sys.modules
!(bind! exec_fn (py-atom "exec"))                          ; Access Python's exec function

; Step 1: Define the module name and source code
!(bind! module_name "greeter")
!(bind! module_source "
def say_hello(name):
    print(f'Hello {name}!')

print('defining it')
")

; Step 2: Create a new module
!(bind! new_module (types_module module_name))           ; Create a new module dynamically

; Step 3: Execute the source code in the module's context
!((exec_fn module_source (py-dot new_module __dict__))) ; Execute the source code in the module's namespace

; Step 4: Add the module to sys.modules
!((py-dot sys_modules __setitem__) module_name new_module)

; Step 5: Test the dynamically created module
!((py-dot new_module say_hello) "World")                ; Call the say_hello function in the dynamic module

!(new_module)