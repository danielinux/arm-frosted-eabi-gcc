# Frosted ARM Cross Compiler

This project builds a cross-compiler toolchain for compiling flat binaries for position-independent XIP (eXecute In Place) on ARMv8-M (Cortex-M33) systems.

## Overview

The Frosted OS stores all binaries as PIE (Position Independent Executables) in a special XIP filesystem (xipfs). The text is executed in place, with the GOT (Global Offset Table) PIC table stored into the rregister r9 at runtime.

## Toolchain Components

- **Cross-compiler**: Built using crosstool-ng, installed locally in `cmd/bin`
- **elf2flt**: Modified with a small patch to support Frosted OS requirements
- **Newlib**: Forked: redirect system calls to proper SVC instructions via a custom `arm-frosted` libgloss

## Build Process

The build process is automated through the `build.sh` script which:
1. Creates a local `cmd` directory for installation
2. Builds and installs crosstool-ng in the local directory
3. Configures the toolchain using `arm-frosted-eabi.config.in`
4. Patches elf2flt with `elf2flt-frosted-patch.diff`
5. Builds the complete toolchain

## Target System

- ARMv8-M architecture (Cortex-M33) running Frosted OS
- Position-independent executables for storage in XIPFS
- SVC instruction-based system calls following the Frosted API

## Usage

Run `./build.sh` to build the cross-compiler toolchain.
