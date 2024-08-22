import gleam/io
import gleam/string

pub type Runtime {
  Erlang
  Node
  Bun
  Deno
  Browser
  OtherRuntime(String)
}

pub type Os {
  Aix
  Darwin
  FreeBsd
  Linux
  OpenBsd
  SunOs
  Win32
  OtherOs(String)
}

// Architecture list from node's docs

pub type Arch {
  Arm
  Arm64
  X86
  X64
  Loong64
  Mips
  MipsLittleEndian
  PPC
  PPC64
  RiscV64
  S390
  S390X
  OtherArch(String)
}

@external(erlang, "platform_ffi", "runtime")
@external(javascript, "./platform_ffi.mjs", "runtime")
fn runtime_() -> String

@external(erlang, "platform_ffi", "os")
@external(javascript, "./platform_ffi.mjs", "os")
fn os_() -> String

@external(erlang, "platform_ffi", "arch")
@external(javascript, "./platform_ffi.mjs", "arch")
fn arch_() -> String

pub fn runtime() -> Runtime {
  case runtime_() {
    "erlang" -> Erlang
    "node" -> Node
    "bun" -> Bun
    "deno" -> Deno
    "browser" -> Browser
    runtime -> OtherRuntime(runtime)
  }
}

pub fn os() -> Os {
  case os_() {
    "aix" -> Aix
    "darwin" -> Darwin
    "freebsd" -> FreeBsd
    "linux" -> Linux
    "openbsd" -> OpenBsd
    "sunos" -> SunOs
    "win32" | "win" <> _ -> Win32
    os -> OtherOs(os)
  }
}

pub fn arch() -> Arch {
  case string.lowercase(arch_()) {
    "arm" -> Arm
    "arm64" | "aarch64" -> Arm64
    "x86" | "ia32" -> X86
    "x64" | "x86_64" | "amd64" -> X64
    "loong64" -> Loong64
    "mips" -> Mips
    "mipsel" -> MipsLittleEndian
    "ppc" -> PPC
    "ppc64" -> PPC64
    "riscv64" -> RiscV64
    "s390" -> S390
    "s390x" -> S390X
    arch -> OtherArch(arch)
  }
}

pub fn main() {
  // io.debug("Runtime")
  io.debug(runtime())
  // io.debug("Os")
  io.debug(os())
  // io.debug("Arch")
  io.debug(arch())
}
