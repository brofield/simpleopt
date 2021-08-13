#!/bin/bash



# -------------------------------------------------------
# procedure: run a single test case
testcase() {
    echo "" 
    echo "fullSample $@" 
    ./fullSample $@ 
}

# -------------------------------------------------------
# procedure: run all test cases

testcase -d -e -f -g -flag --flag
testcase -s SEP1 -sep SEP2 --sep SEP3
testcase -s -s SEP1 -sep SEP2 --sep SEP3
testcase --noerr -s -s SEP1 -sep SEP2 --sep SEP3
testcase FILE0 -s SEP1 FILE1 -sep SEP2 FILE2 --sep SEP3 FILE3
testcase FILE0 -s=SEP1 FILE1 -sep=SEP2 FILE2 --sep=SEP3 FILE3
testcase --pedantic FILE0 -s=SEP1 FILE1 -sep=SEP2 FILE2 --sep=SEP3 FILE3
testcase -c=COM1 -com=COM2 --com=COM3
testcase --shortarg -cCOM
testcase --shortarg -cCOM1 -c=COM2
testcase --shortarg --clump -defgcCOM1 -c=COM2
testcase -o -opt --opt -o=OPT1 -opt=OPT2 --opt=OPT3
testcase --shortarg -oOPT1
testcase -man -mand -mandy -manda -mandat -mandate
testcase --man --mand --mandy --manda --mandat --mandate
testcase --exact -man -mand -mandy -manda -mandat -mandate
testcase FILE0 FILE1
testcase --multi0 --multi1 ARG1 --multi2 ARG1 ARG2
testcase FILE0 --multi0 FILE1 --multi1 ARG1 FILE2 --multi2 ARG1 ARG2 FILE3
testcase FILE0 --multi 0 FILE1 --multi 4 ARG1 ARG2 ARG3 ARG4 FILE3
testcase --multi 0
testcase --multi 1
testcase FILE0 --multi 1
testcase -sep SEP1
testcase /-sep SEP1
testcase --noslash /sep SEP1
testcase --multi 1 -sep
testcase --noerr --multi 1 -sep
testcase open file1 read file2 write file3 close file4 zip file5 unzip file6
testcase upcase
testcase UPCASE
testcase --icase upcase
testcase -E -F -S sep1 -SEP sep2 --SEP sep3
testcase --icase -E -F -S sep1 -SEP sep2 --SEP sep3 upcase
testcase --icase-short -E -F -S sep1 -SEP sep2 --SEP sep3 upcase
testcase --icase-long  -E -F -S sep1 -SEP sep2 --SEP sep3 upcase
testcase --icase-word  -E -F -S sep1 -SEP sep2 --SEP sep3 upcase
testcase --exact a b c d e f g h i j k l m n o p q r s t u v w x y z a b c d e f g h i j k l m n o p q r s t u v w x y z
testcase --
testcase f1 -- f2
testcase -man -- f1 f2
testcase -- -man f1 f2
testcase f1 -- -man f2
testcase --clump -d
testcase --clump -defg
testcase --clump -a
testcase --clump -da
testcase --clump -ad
testcase --clump -dae
