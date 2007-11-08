FOR /F "tokens=*" %%G IN ('DIR /AD /B /S basic*') DO (
    DEL /S /Q "%%G"
    RD "%%G"
)
FOR /F "tokens=*" %%G IN ('DIR /AD /B /S full*') DO (
    DEL /S /Q "%%G"
    RD "%%G"
)
FOR /F "tokens=*" %%G IN ('DIR /AD /B /S glob*') DO (
    DEL /S /Q "%%G"
    RD "%%G"
)
DEL /Q "runtests.full*"
DEL /Q "simpleOpt.ncb"
ATTRIB -H "simpleOpt.suo"
DEL /Q "simpleOpt.suo"
START "Generate documentation" /WAIT simpleOpt.doxy
cd ..
del simpleopt-x.zip
zip simpleopt-x.zip simpleopt/*.*
del simpleopt-dic.zip
zip -r simpleopt-doc.zip simpleopt-doc/
cd simpleopt
