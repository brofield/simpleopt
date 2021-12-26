set VERSION=3.6

set SEVENZIP="C:\Program Files\7-Zip\7z.exe"

FOR /F "tokens=*" %%G IN ('DIR /AD /B /S examples\basic*') DO (
    DEL /S /Q "%%G"
    RD "%%G"
)
FOR /F "tokens=*" %%G IN ('DIR /AD /B /S examples\full*') DO (
    DEL /S /Q "%%G"
    RD "%%G"
)
FOR /F "tokens=*" %%G IN ('DIR /AD /B /S examples\glob*') DO (
    DEL /S /Q "%%G"
    RD "%%G"
)
DEL /Q "examples\runtests.full*"
DEL /Q "simpleOpt.ncb"
ATTRIB -H "simpleOpt.suo"
DEL /Q "simpleOpt.suo"
DEL /Q "simpleOpt.opt"
START "Generate documentation" /WAIT simpleOpt.doxy
cd ..
del simpleopt-%VERSION%.zip
%SEVENZIP% a -tzip -r- -x!simpleopt\.svn simpleopt-%VERSION%.zip simpleopt\*
del simpleopt-doc.zip
%SEVENZIP% a -tzip -r simpleopt-doc.zip simpleopt-doc\*
cd simpleopt
