Here is a minimal example of blinking an LED on a P2 Eval board using Rust. This is currently just a proof of concept: actually doing useful things with Rust will take more work.

To use it, you'll have to have Rust installed on your host computer via `rustup`. I used a PC running Linux (Debian 12 in fact); I'm not sure how easy/hard it would be to reproduce this under Windows, although using Windows Subsystem for Linux (WSL) it should be straightforward.

Add support for cross compilation by doing:
```
rustup default stable
rustup target add riscv32-imacunknown-none-elf
cargo install cargo-binutils
```

The engine underlying this work is my own riscvp2 project (https://github.com/totalspectrum/riscvpt) which is a just-in-time compiler from the RISC-V instruction set (specifically the rv32imac one) to the Parallax Propeller P2. That's the "glue" that makes all of this work: Rust is compiling for the RISC-V, and a small stub gets linked in to make the code run on the P2.

I created this by more-or-less following the Rust Embedonomicon (https://docs.rust-embedded.org/embedonomicon/preface.html) which is an excellent resource for very low level programming.

I'm grateful to my employer, Collabora (www.collabora.com) for giving me time to learn Rust.
