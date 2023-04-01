
___
# LAB1

**Compilation and execution process**
The general process from C source to a running program has four preparation steps:


Preprocessor processes one C source file at a time: for each it expands macros (#define's), inserts contents of included files (#include's) and produces intermediate file also known as translation unit. Each translation unit is compiled separately.

Compiler translates C source from each translation unit into target machine code, resulting in object file. Object files contain machine instructions and debug symbols, but they have no set links to any libraries or other translation units. You can not run object files.

Linker merges multiple object files adding address bindings between them, and also to static libraries which are permanently added to same output file. This output file is executable binary or executable, and it typically contains debug symbols in ELF format.

Loader loads the executable from mass memory (HDD or SSD) into main memory (DRAM), and links the code to dynamic libraries (Windows DLL) / shared libraries (Linux .so) in the system. Dynamic libraries aim to minimise the main memory usage for the complete system: If all running programs use printf for output, it is not necessary to load a separate library instance for every application. The applications can share one dynamic library. Loader makes sure all required shared libraries are loaded before the executable is started. Note that in bare-metal systems there is no OS and no loader, so linker must prepare complete system memory image.

![image](https://user-images.githubusercontent.com/44445562/229284976-039d4abd-f047-45ea-8f92-cfa0ba94e7d8.png)

___
