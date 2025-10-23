# MLKEM-libjade

**mlkem-libjade** is a formally verified library implementing ML-KEM[^FIPS203].

The implementation is written in Jasmin[^Jasmin], and proved to be **safe**, **constant-time**, **speculative constant-time** and **functionally correct** using EasyCrypt[^EasyCrypt].

This project is part of the **libjade** package, which provides a collection of high-assurance and high-speed cryptographic libraries implemented in Jasmin and formally verified using EasyCrypt.

The Jasmin compiler produces assembly, so all code in this implementation is platform specific.



## 🧩 Supported Variants

The current implementation supports:
- **ML-KEM-768**
- **ML-KEM-1024**

Each variant includes two versions:
- **AVX2** (optimized for x86-64 with the AVX2 instruction set)
- **Reference** (a straightforward, reference-style implementation)

## ⚙️ Usage

Each implementation directory contains five files:
- A C header (`.h`) file
- An assembly (`.s`) file
- The original Jasmin source (`.jazz`) used to produce the `.s`
- An example file (`example.c`) demonstrating how to use the library
- A `Makefile` to build the example

To integrate this library into your project, you only need:
- The `.h` file
- The `.s` file

The remaining files are provided for reference:
- The `.jazz` file shows the original Jasmin implementation
- `example.c` demonstrates usage of the exported C functions
- The `Makefile` builds the C example program


<!-- 
## File Structure

| -- src
|    | -- mlkem768
|    |    | -- avx2
|    |    | -- reference
|    | -- mlkem1024
|         | -- avx2
|         | -- reference
| -- examples
|    | -- mlkem768
|    |    | -- avx2
|    |    | -- reference
|    | -- mlkem1024
|         | -- avx2
|         | -- reference
| -- README.md
| -- benchmarks.md ??
| -- scripts ??
| -- proofs ??
| -- .github
|    | -- workflows -->





## 🧠 Formal Verification

Formal verification is divided into two main components:

1. **Verified Compilation:**  
   The Jasmin compiler is verified to ensure that the generated assembly is functionally equivalent to the original Jasmin code.  
   It also guarantees that the Jasmin code extracted for EasyCrypt verification corresponds to the code compiled to assembly.

2. **Program Proofs:**  
   Safety proofs are established in EasyCrypt to ensure the Jasmin code satisfies all compiler safety assumptions.  
   Additional EasyCrypt proofs establish **functional correctness**.
   The Jasmin compiler also provides a method for checking **security properties** such as constant-time and speculative constant-time execution.

All formal proofs for correctness and safety can be found in the [proof directory](https://github.com/formosa-crypto/formosa-mlkem/tree/master/proof).



## 🚀 Benchmarking

Performance benchmarks are documented in [benchmarks.md](benchmarks.md) and are generated automatically by the CI.



## 🤝 Contributing

Contributions are welcome!  
If you’d like to help develop or improve **mlkem-libjade**, please contact our team via [Formosa Crypto Zulip](https://formosa-crypto.zulipchat.com).






## 📚 References

[^Jasmin]: Jasmin: High-Assurance and High-Speed Cryptography, [https://github.com/jasmin-lang/jasmin](https://github.com/jasmin-lang/jasmin)
[^EasyCrypt]: EasyCrypt: A tool for reasoning about relational properties of probabilistic computations, [https://github.com/EasyCrypt/easycrypt](https://github.com/EasyCrypt/easycrypt)
[^FIPS203]: National Institute of Standards and Technology: FIPS 203 Module-Lattice-Based Key-Encapsulation Mechanism Standard, [https://csrc.nist.gov/pubs/fips/203/final](https://csrc.nist.gov/pubs/fips/203/final)
