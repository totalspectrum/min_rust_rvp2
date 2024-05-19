//
// Simple P2 LED blinker
// Written by Eric R. Smith <eric.smith@collabora.com>
// Copyright 2024 Collabora Ltd.
// SPDX-License-Identifier: MIT
//

#![no_main]
#![no_std]

use core::panic::PanicInfo;
use core::arch::asm;

#[panic_handler]
fn panic(_panic: &PanicInfo<'_>) -> ! {
  loop { }
}

#[no_mangle]
pub unsafe extern "C" fn _start() -> ! {
  loop {
    pintoggle(57);
    delay(20_000_000);
  }
}

fn pintoggle( p: u32 ) {
  unsafe {
    asm!(
      ".insn s CUSTOM_0, 2, x0, -0x400({z})",
        z = in(reg) p
      );
  }
}

fn delay( n: u32 ) {
  unsafe {
    asm!(
      ".insn i CUSTOM_1, 1, x0, 31({zi})",
        zi = in(reg) n
      );
  }
}
