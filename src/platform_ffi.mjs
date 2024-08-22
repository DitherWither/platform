"use strict";

export function runtime() {
  if (globalThis.Deno) {
    return "deno";
  }
  if (globalThis.Bun) {
    return "bun";
  }
  if (globalThis.process?.release?.name === "node") {
    return "node";
  }

  if (window !== "undefined" && typeof window.document !== "undefined") {
    return "browser";
  }

  return "unknown";

}

export function os() {
    const currentRuntime = runtime();

    if (currentRuntime === "node" || currentRuntime === "bun") {
        return process.platform;
    }
    if (currentRuntime === "browser") {
        // TODO get browser's host os using user agent data
        return "unknown";
    }
    // if (currentRuntime === "deno") {
    //     const {platform} = await import("node:process")
    //     return platform;
    // }
    return "unknown";
}

export function arch() {
    const currentRuntime = runtime();

    if (currentRuntime === "node" || currentRuntime === "bun") {
        return process.arch;
    }
    // if (currentRuntime === "deno") {
    //     const {arch} = await import("node:process")
    //     return arch;
    // }
    if (currentRuntime === "browser") {
        // TODO get browser's architecture using user agent data
        return "unknown";
    }

    return "unknown";
}