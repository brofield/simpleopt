A cross-platform file globbing library providing the ability to
expand wildcards in command-line arguments to a list of all matching
files. It is designed explicitly to be portable to any platform and has
been tested on Windows and Linux. See the class definition for more details.

##FEATURES
- MIT Licence allows free use in all software (including GPL and commercial)
- multi-platform (Windows 95/98/ME/NT/2K/XP, Linux, Unix)
- supports most of the standard linux glob() options
- recognition of a forward paths as equivalent to a backward slash on Windows. e.g. "c:/path/foo*" is equivalent to "c:\path\foo*".
- implemented with only a single C++ header file
- char, wchar_t and Windows TCHAR in the same program
- complete working examples included
- compiles cleanly at warning level 4 (Windows/VC.NET 2003), warning level 3 (Windows/VC6) and -Wall (Linux/gcc)

##USAGE

Follow these steps:
- Include the SimpleGlob.h header file
```c++
    #include "SimpleGlob.h"
```

- Instantiate a CSimpleGlob object supplying the appropriate flags.
```c++
    CSimpleGlob glob(FLAGS);
```

- Add all file specifications to the glob class.
```c++
    glob.Add("file*");
    glob.Add(argc, argv);
```

- Process all files with File(), Files() and FileCount()
```c++
    for (int n = 0; n < glob.FileCount(); ++n) {
        ProcessFile(glob.File(n));
    }
```
