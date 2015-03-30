#SimpleOpt

A cross-platform command line library which can parse almost any of the standard command line formats in use today. It is designed explicitly to be portable to any platform and has been tested on Windows and Linux. 

##FEATURES
* MIT Licence allows free use in all software (including GPL and commercial)
* multi-platform (Windows 95/98/ME/NT/2K/XP, Linux, Unix)
* supports all lengths of option names:

Style    | Description
-------- | -----------
-        | switch character only (e.g. use stdin for input)
-o       | short (single character)
-long    | long (multiple character, single switch character)
--longer | long (multiple character, multiple switch characters)

* supports all types of arguments for options:

Style          | Description
-------------- | -----------
--option       | short/long option flag (no argument)
--option ARG   | short/long option with separate required argument
--option=ARG   | short/long option with combined required argument
--option[=ARG] | short/long option with combined optional argument
-oARG          | short option with combined required argument
-o[ARG]        | short option with combined optional argument

* supports options with multiple or variable numbers of arguments:

Style                           | Description
------------------------------- | -----------
--multi ARG1 ARG2               | Multiple arguments
--multi N ARG-1 ARG-2 ... ARG-N | Variable number of arguments

* supports case-insensitive option matching on short, long and/or word arguments.
* supports options which do not use a switch character. i.e. a special word which is construed as an option.  
    ```foo.exe open /directory/file.txt```
* supports clumping of multiple short options (no arguments) in a string.  
    ```foo.exe -abcdef file1``` is equivalent to ```foo.exe -a -b -c -d -e -f file1```
* automatic recognition of a single slash as equivalent to a single hyphen on Windows  
    ```/f FILE``` is equivalent to ```-f FILE```
* file arguments can appear anywhere in the argument list:  
    ```foo.exe file1.txt -a ARG file2.txt --flag file3.txt file4.txt```  
  Note that files will be returned to the application in the same order they were supplied on the command line
* short-circuit option matching:  
    ```--man``` will match ```--mandate```
* invalid options can be handled while continuing to parse the command line valid options list can be changed dynamically during command line processing, i.e. accept different options depending on an option supplied earlier in the command line.
* implemented with only a single C++ header file
* optionally use no C runtime or OS functions
* char, wchar_t and Windows TCHAR in the same program
* complete working examples included
* compiles cleanly at warning level 4 (Windows/VC.NET 2003), warning level 3 (Windows/VC6) and -Wall (Linux/gcc)

##USAGE
The SimpleOpt class is used by following these steps:
* Include the SimpleOpt.h header file
```c++
#include "SimpleOpt.h"
```
* Define an array of valid options for your program. Note that this can be switched to a different table during processing as desired.
```c++
CSimpleOpt::SOption g_rgOptions[] = {
    { OPT_FLAG, "-a", SO_NONE },     // "-a"
    { OPT_FLAG, "-b", SO_NONE },     // "-b"
    { OPT_ARG,  "-f", SO_REQ_SEP },  // "-f ARG"
    { OPT_HELP, "-?", SO_NONE },     // "-?"
    { OPT_HELP, "--help", SO_NONE }, // "--help"
    SO_END_OF_OPTIONS                // END
};
```
Note that all options must start with a hyphen even if the slash will be accepted. This is because the slash character is automatically converted into a hyphen to test against the list of options. For example, the following line matches both ```-?``` and ```/?``` (on Windows).
```c++
    { OPT_HELP, "-?", SO_NONE }, // "-?"
```
*Instantiate a CSimpleOpt object supplying argc, argv and the option table
```c++
    CSimpleOpt args(argc, argv, g_rgOptions);
```
* Process the arguments by calling Next() until it returns false. On each call, first check for an error by calling LastError(), then either handle the error or process the argument.
```c++
while (args.Next()) {
    if (args.LastError() == SO_SUCCESS) {
        // handle option: use OptionId(), OptionText() and OptionArg()
    }
    else {
        // handle error: see ESOError enums
    }
}
```
* Process all non-option arguments with File(), Files() and FileCount()
```c++
ShowFiles(args.FileCount(), args.Files());
```

##NOTES
* In MBCS mode, this library is guaranteed to work correctly only when all option names use only ASCII characters.
* Note that if case-insensitive matching is being used then the first matching option in the argument list will be returned.

# SimpleGlob

A cross-platform file globbing library providing the ability to
expand wildcards in command-line arguments to a list of all matching
files. It is designed explicitly to be portable to any platform and has
been tested on Windows and Linux. See the class definition for more details.

##FEATURES
- MIT Licence allows free use in all software (including GPL and commercial)
- multi-platform (Windows 95/98/ME/NT/2K/XP, Linux, Unix)
- supports most of the standard linux glob() options
- recognition of a forward paths as equivalent to a backward slash on Windows (only):  
    ```c:/path/foo*``` is equivalent to ```c:\path\foo*```
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
