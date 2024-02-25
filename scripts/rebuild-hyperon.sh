#!/bin/bash -x


export VPSACE=$PWD

(
set -v -x -e
cd ../hyperon-experimental

# Prepare environment
rustup update stable
cargo install --force cbindgen
pip install -U pip
pip install conan==1.60.1
conan profile new --detect default | true
#pip install pip==23.1.2
pip install pip==23.2.1

# Build Hyperon library
cd ./lib
cargo clean
cargo build
cargo test
cargo doc --no-deps
cd ..

# Build C and Python API
rm -rf build
mkdir -p build; cd build
cmake ..
make -j4
make check
cd ..

# Install python library and executables
# pip install -v -e ./python[dev]
python3 -m pip install -v -e ./python[dev]

# Build Hyperon MeTTa-REPL
cd ./repl
cargo clean
cargo build 
cargo test 
cargo install --path=. 
cargo doc --no-deps 
cd ..

# Test
cd python
pytest ./tests
cd ..

(
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
)

cd $VPSACE

)
(
python -m pip install -r requirements.txt
)

