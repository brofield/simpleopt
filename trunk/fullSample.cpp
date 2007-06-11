// File:    fullSample.cpp
// Library: SimpleOpt
// Author:  Brodie Thiesfield <code@jellycan.com>
// Source:  http://code.jellycan.com/simpleopt/
//
// MIT LICENCE
// ===========
// The licence text below is the boilerplate "MIT Licence" used from:
// http://www.opensource.org/licenses/mit-license.php
//
// Copyright (c) 2006, Brodie Thiesfield
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is furnished
// to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#if defined(_MSC_VER)
# include <windows.h>
# include <tchar.h>
#else
# define TCHAR		char
# define _T(x)		x
# define _tprintf	printf
# define _tmain		main
#endif

#include <stdio.h>
#include <locale.h>
#include "SimpleOpt.h"
#include "SimpleGlob.h"

static void ShowUsage()
{
    _tprintf(
        _T("Usage: fullSample [OPTIONS] [FILES]\n")
        _T("\n")
        _T("--exact     Disallow partial matching of option names\n")
        _T("--noslash   Disallow use of slash as an option marker on Windows\n")
        _T("--shortarg  Permit arguments on single letter options with no equals sign\n")
        _T("--clump     Permit single char options to be clumped as long string\n")
        _T("--noerr     Do not generate any errors for invalid options\n")
        _T("\n")
        _T("-d  -e  -f  -g  -flag  --flag               Flag (no arg)\n")
        _T("-s ARG   -sep ARG  --sep ARG                Separate required arg\n")
        _T("-cARG    -c=ARG    -com=ARG    --com=ARG    Combined required arg\n")
        _T("-o[ARG]  -o[=ARG]  -opt[=ARG]  --opt[=ARG]  Combined optional arg\n")
        _T("-man     -mandy    -mandate                 Shortcut matching tests\n")
        _T("--man    --mandy   --mandate                Shortcut matching tests\n")
        _T("open read write close zip unzip             Special words\n")
        _T("\n")
        _T("-?  -h  -help  --help                       Output this help.\n")
        _T("\n")
        _T("If a FILE is `-', read standard input.\n")
        );
}

CSimpleOpt::SOption g_rgFlags[] =
{
    { SO_O_EXACT,    _T("--exact"),     SO_NONE },
    { SO_O_NOSLASH,  _T("--noslash"),   SO_NONE },
    { SO_O_SHORTARG, _T("--shortarg"),  SO_NONE },
    { SO_O_CLUMP,    _T("--clump"),     SO_NONE },
    { SO_O_NOERR,    _T("--noerr"),     SO_NONE },
    SO_END_OF_OPTIONS
};

enum { OPT_HELP = 1000 };
CSimpleOpt::SOption g_rgOptions[] =
{
    { OPT_HELP,  _T("-?"),           SO_NONE    },
    { OPT_HELP,  _T("-h"),           SO_NONE    },
    { OPT_HELP,  _T("-help"),        SO_NONE    },
    { OPT_HELP,  _T("--help"),       SO_NONE    },
    {  1,        _T("-"),            SO_NONE    },
    {  2,        _T("-d"),           SO_NONE    },
    {  3,        _T("-e"),           SO_NONE    },
    {  4,        _T("-f"),           SO_NONE    },
    {  5,        _T("-g"),           SO_NONE    },
    {  6,        _T("-flag"),        SO_NONE    },
    {  7,        _T("--flag"),       SO_NONE    },
    {  8,        _T("-s"),           SO_REQ_SEP },
    {  9,        _T("-sep"),         SO_REQ_SEP },
    { 10,        _T("--sep"),        SO_REQ_SEP },
    { 11,        _T("-c"),           SO_REQ_CMB },
    { 12,        _T("-com"),         SO_REQ_CMB },
    { 13,        _T("--com"),        SO_REQ_CMB },
    { 14,        _T("-o"),           SO_OPT     },
    { 15,        _T("-opt"),         SO_OPT     },
    { 16,        _T("--opt"),        SO_OPT     },
    { 17,        _T("-man"),         SO_NONE    },
    { 18,        _T("-mandy"),       SO_NONE    },
    { 19,        _T("-mandate"),     SO_NONE    },
    { 20,        _T("--man"),        SO_NONE    },
    { 21,        _T("--mandy"),      SO_NONE    },
    { 22,        _T("--mandate"),    SO_NONE    },
    { 23,        _T("open"),         SO_NONE    },
    { 24,        _T("read"),         SO_NONE    },
    { 25,        _T("write"),        SO_NONE    },
    { 26,        _T("close"),        SO_NONE    },
    { 27,        _T("zip"),          SO_NONE    },
    { 28,        _T("unzip"),        SO_NONE    },
    SO_END_OF_OPTIONS
};

void ShowFiles(int argc, TCHAR ** argv) {
    // glob files to catch expand wildcards
    CSimpleGlob glob(SG_GLOB_NODOT|SG_GLOB_NOCHECK);
    if (SG_SUCCESS != glob.Add(argc, argv)) {
        _tprintf(_T("Error while globbing files\n"));
        return;
    }

    for (int n = 0; n < glob.FileCount(); ++n) {
        _tprintf(_T("file %2d: '%s'\n"), n, glob.File(n));
    }
}

int _tmain(int argc, TCHAR * argv[]) {
    setlocale( LC_ALL, "Japanese" );

    // get the flags to use for SimpleOpt from the command line
    int nFlags = SO_O_USEALL;
    CSimpleOpt flags(argc, argv, g_rgFlags, SO_O_NOERR|SO_O_EXACT);
    while (flags.Next()) {
        nFlags |= flags.OptionId();
    }

    // now process the remainder of the command line with these flags
    CSimpleOpt args(flags.FileCount(), flags.Files(), g_rgOptions, nFlags);
    while (args.Next()) {
        if (args.LastError() != SO_SUCCESS) {
            TCHAR * pszError = _T("Unknown error");
            switch (args.LastError()) {
            case SO_OPT_INVALID:
                pszError = _T("Unrecognized option");
                break;
            case SO_OPT_MULTIPLE:
                pszError = _T("Option matched multiple strings");
                break;
            case SO_ARG_INVALID:
                pszError = _T("Option does not accept argument");
                break;
            case SO_ARG_INVALID_TYPE:
                pszError = _T("Invalid argument format");
                break;
            case SO_ARG_MISSING:
                pszError = _T("Required argument is missing");
                break;
            case SO_SUCCESS:
                pszError = NULL;
            }
            _tprintf(
                _T("%s: '%s' (use --help to get command line help)\n"),
                pszError, args.OptionText());
            continue;
        }

        if (args.OptionId() == OPT_HELP) {
            ShowUsage();
            return 0;
        }

        if (args.OptionArg()) {
            _tprintf(_T("option: %2d, text: '%s', arg: '%s'\n"),
                args.OptionId(), args.OptionText(), args.OptionArg());
        }
        else {
            _tprintf(_T("option: %2d, text: '%s'\n"),
                args.OptionId(), args.OptionText());
        }
    }

    /* process files from command line */
    ShowFiles(args.FileCount(), args.Files());

	return 0;
}
