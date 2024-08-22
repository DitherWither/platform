import gleam/io
import platform

pub fn main() {
  io.debug(platform.runtime())
  io.debug(platform.arch())
  io.debug(platform.os())
}
