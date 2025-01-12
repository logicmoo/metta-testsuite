



; Define a function to create and register a Python module dynamically
(= (py-module $module_name $module_source)
  (if (== String (get-metatype $module_name))
	  (py-nmodule $module_name $module_source)
      (py-nmodule (repr $module_name) $module_source)))

(= (py-nmodule $module_name $module_source)
  (let $types_module (py-atom "types.ModuleType")         ; Access types.ModuleType
    (let $sys_modules (py-atom "sys.modules")             ; Access sys.modules
      (let $exec_fn (py-atom "exec")                      ; Access Python's exec function
        (let $new_module ($types_module $module_name)     ; Create a new module dynamically
          (let $_ (
            ($exec_fn $module_source (py-dot $new_module __dict__)) ; Execute source code in the module's namespace
            ((py-dot $sys_modules __setitem__) $module_name $new_module)) ; Register the module in sys.modules
            $new_module)))))) ; Return the created module


; Define a function to create and register a Python module dynamically without requiring a module name
(= (py-module $module_source)
  (let $uuid_module (py-atom "uuid")                     ; Access the uuid module
	(let $uuid4_fn (py-atom "uuid.uuid4") ; Access uuid.uuid4 for unique name generation
	  (let $str_fn (py-atom "str")                       ; Access Python's str function
		(let $module_name ($str_fn ($uuid4_fn))        ; Generate a unique module name
		  (py-module $module_name $module_source)))))) ; Delegate to py-module-with-name


; Create the module using the function
!(bind! greeter (py-module bar "
def say_hello(name):
    print(f'Hello {name}, from module: {__name__}!')

print('Module defined say_hello.')
"))

!(bind! anonymous-greeter (py-module "
def say_hello(name):
	print(f'Hello {name}, from module: {__name__}!')

print(f'Module {__name__}! defined say_hello.')
"))

!((py-dot greeter say_hello) "World")
!((py-dot anonymous-greeter say_hello) "World A")





