# MeTTa Test Suite

This repository contains a collection of tests designed to validate and ensure compatibility between various MeTTa-related projects and their interpreters. It serves as a centralized location for tests that can be run against different back-end implementations or experimental setups.

For descriptions of individual test directories, please see [tests/README.md](./tests/README.md).

## Interpreter Projects
  - **MeTTaLog**  
| [https://github.com/trueagi-io/metta-wam/](https://github.com/trueagi-io/metta-wam/) | **MeTTaLog Official** – Main repository for MeTTaLog |
| [https://github.com/logicmoo/metta-wam/](https://github.com/logicmoo/metta-wam/) | **Compiler Development** – Active development of the MeTTa compiler |
| [https://github.com/logicmoo/metta-testsuite/tree/master](https://github.com/logicmoo/metta-testsuite/tree/master) | **Interpreter Development** – Work on the MeTTa interpreter |
| [https://github.com/logicmoo/metta-testsuite/tree/development](https://github.com/logicmoo/metta-testsuite/tree/development) | **Testing Suite** – Development branch for automated tests |

- **Hyperon Experimental (H-E)**  
  [https://github.com/trueagi-io/hyperon-experimental/](https://github.com/trueagi-io/hyperon-experimental/)  

- **MORK**  
  [https://github.com/trueagi-io/MORK/](https://github.com/trueagi-io/MORK/)

- **METTA-Morph**

  [https://github.com/trueagi-io/metta-morph](https://github.com/trueagi-io/metta-morph/)

## How This Test Suite Is Organized

This repository is organized into test cases focusing on different aspects of MeTTa code execution and semantics. Each test is intended to be run against one or more of the interpreters listed above. By doing so, we aim to:

- Ensure consistent behavior and output across different implementations.
- Identify implementation-specific issues or deviations from the expected MeTTa semantics.
- Provide a basis for regression tests as the MeTTa ecosystem evolves.

## Running the Tests

1. **Clone this repository:**
   ```bash
   git clone https://github.com/logicmoo/metta-testsuite.git
   cd metta-testsuite
   ```

2. **Choose an Interpreter:**
   Make sure you have a compatible interpreter (Hyperon Experimental, MORK, or MeTTaLog) installed or accessible. Instructions for installation or building can be found in their respective repositories.

3. **Execute the Tests:**
   Depending on which interpreter you’re testing against, follow the instructions provided by that interpreter’s documentation to run the tests. Typically, this may involve commands like:
   ```bash
   # Example (adjust depending on the interpreter)
   <interpreter_command> test/* 
   ```
   
   Refer to the individual interpreter repos for detailed guidance on running external test suites.

## Contributing

Contributions to this test suite are welcome. If you have identified new cases that should be tested, or if you’ve noticed discrepancies between interpreters, feel free to open a pull request or discuss it via the issues section of this repository.

## Filing Issues

- **Interpreters’ Issues:**  
  If you encounter a problem you believe is due to a specific interpreter’s behavior, please file the issue **in the corresponding interpreter repository** (e.g., H-E, MORK, or MeTTaLog).

- **Test Case Issues:**  
  If you suspect that a test is poorly designed, incorrect, or needs clarification, file an issue **here in this repository**. This will help us improve the quality, coverage, and clarity of the test cases.


