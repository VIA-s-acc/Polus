#1734003272
lscpu
#1734003291
nproc
#1734003295
htop
#1734003319
vim
#1734003505
ls
#1734003507
clear
#1734003513
lcpu
#1734003515
lscpu
#1734003518
quit
#1734011480
mkdir prac
#1734011481
cd prac
#1734011487
vim test.c
#1734011685
clear
#1734011687
vim test.c 
#1734012938
module load SpectrumMPI
#1734013078
mpixlc -o program test.c 
#1734013087
vim test.c 
#1734013122
mpixlc -o program test.c 
#1734013127
ls
#1734013130
./program 
#1734013146
clear
#1734013196
mpisubmit -p 4 ./program --10
#1734013205
mpisubmit.pl -p 4 ./program --10
#1734013216
mpisubmit.pl -p 4 ./program --n=10
#1734013274
bjobs
#1734013297
bjobs -u all
#1734013378
bjobs
#1734013382
ls
#1734013435
cat program.126808.out
#1734013446
cat ./program.126808.out
#1734013455
cat ./program.1268085.out
#1734013495
cat ./program.1268087.out
#1734013597
mpisubmit.pl -p 4 ./program -- n=10
#1734013600
vim test.c 
#1734013618
mpisubmit.pl -p 4 ./program -- N=10
#1734013622
ls
#1734013637
cat ./program.1268106.out
#1734013646
vim test.c 
#1734013719
mpisubmit.pl -p 4 ./program -- N=10
#1734013721
ls
#1734013727
cat ./program.1268107.out
#1734013752
vim test.c 
#1734013782
mpisubmit.pl -p 4 ./program -- N=10 A=1 B=2 
#1734013791
cat ./program.1268111.out
#1734013798
cat ./program.1268111.err
#1734013802
ls
#1734013805
cat ./program.1268111.err
#1734013811
cat ./program.1268111.out
#1734013818
vim test.c
#1734013860
mpisubmit.pl -p 4 ./program -- N=10 A=1 B=2 
#1734013866
cat ./program.1268113.out
#1734013885
clear
#1734013886
cat ./program.1268113.out
#1734013948
cat ./program.1268113.err
#1734013953
vim test.c
#1734014054
mpixlc -o program test.c 
#1734014059
mpisubmit.pl -p 4 ./program -- N=10 A=1 B=2 
#1734014066
cat ./program.1268118.err
#1734014068

#1734014102
vim test.c
#1734014145
mpixlc -o program test.c 
#1734014148
mpisubmit.pl -p 4 ./program -- N=10 A=1 B=2 
#1734014158
cat ./program.1268122.out
#1734014165
ls
#1734014173
bjobs
#1734014183
ls
#1734014191
cat ./program.1268122.out
#1734014207
mpisubmit.pl -p 4 ./program -- N=150 A=1 B=2 
#1734014214
bjobs
#1734014219
cat ./program.1268123.out
#1734014237
vim test.c
#1734014245
ls
#1734014288
rm program.126*
#1734014289
ls
#1734014321
vim test.c
#1734541520
ls
#1734541522
cd prac
#1734541524
ls
#1734541524
clear
#1734541533
mpixlc -o program test.c 
#1734541553
l
#1734541558
load Spectrum
#1734541571
module load SpectrumMPI
#1734541573
mpixlc -o program test.c 
#1734541584
mpisubmit.pl -p 4 ./program -- N=150 A=1 B=2 
#1734541585
ls
#1734541591
cat program.1285078.out
#1734541598
mpisubmit.pl -p 4 ./program -- N=99 A=1 B=2 
#1734541601
ls
#1734541608
cat program.1285080.out
#1734541617
cat program.1285080.err
#1734541619
cat program.1285080.out
#1734541624
vim test.c 
#1734541643
rm program.*
#1734541644
ls
#1734541647
rm program 
#1734541648
c;ear
#1734541649
clear
#1734541651
vim test.c 
#1734543852
ls
#1734543855
cd prac/
#1734543856
ls
#1734543857
cd ..
#1734543859
ls
#1734543879
cp
#1734543885
cp test.c prac/test.c
#1734543887
ls
#1734543888
cd prac/
#1734543890
vim r
#1734543893
vim test.c 
#1734543896
ls
#1734543897
clear
#1734543898
vim test.c 
#1734543916
clear
#1734543943
mpixlc -o program test.c 
#1734543957
module load SpectrumMPI
#1734543958
mpixlc -o program test.c 
#1734543975
vim test.c 
#1734544118
mpixlc -o program test.c 
#1734544149
vim test.c
#1734544181
rm test.c 
#1734544183
cd ..
#1734544188
cp test.c prac/test.c
#1734544190
ls
#1734544191
rm test.c 
#1734544193
cd prac/
#1734544196
mpixlc -o program test.c 
#1734544198
ls
#1734544204
python
#1734544341
py -3.12
#1734544342
py -3.10
#1734544344
py -v
#1734544346
py --v
#1734544348
clear
#1734544461
vim generator.py import argparse
#1734544475
celar
#1734544476
clear
#1734544478
ls
#1734544481
vim generator.py 
#1734544528
pip
#1734544533
pip install argparse
#1734544541
cls
#1734544547
python -m venv venv
#1734544550
pip install venv
#1734544561
pip freeze 
#1734544573
python -m virtualenv
#1734544575
python -m virtualenv venv
#1734544579
ls
#1734544591
./venv/bin/
#1734544592
ls 
#1734544597
ls ./venv/bin/
#1734544603
./venv/bin/activate
#1734544606
ls
#1734544610
rm -r venv
#1734544615
python generator.py 
#1734544632
vim generator.py 
#1734544717
python generator.py 
#1734544774
rm generator.py 
#1734544776
vim generator.pyt
#1734544779
ls
#1734544781
rm generator.pyt 
#1734544783
vim generator.py
#1734544789
python generator.py 
#1734544812
rm generator.py 
#1734544814
vim generator.py
#1734544823
python generator.py 
#1734544826
vim generator.py 
#1734544832
python generator.py 
#1734544835
vim generator.py 
#1734544843
python generator.py 
#1734544848
python generator.py -help
#1734544852
python generator.py -h
#1734544857
clear
#1734544859
python generator.py -h
#1734544869
vim generator.py 
#1734544901
python generator.py -h
#1734544908
python generator.py -n 150 
#1734544913
vim generator.py 
#1734545028
python generator.py -n 150 -p False
#1734545031
python generator.py -n 150 -p false
#1734545036
python generator.py -h
#1734545040
python generator.py -n 150 -p 1
#1734545042
python generator.py -n 150 -p 
#1734545045
python generator.py -n 150 
#1734545047
ls
#1734545050
vim A.bat 
#1734545053
cls
#1734545054
vim A.bat 
#1734545057
Clear
#1734545058
clear
#1734545060
vim A.bat 
#1734545063
clear
#1734545070
python generator.py -h
#1734545085
mpisubmit.pl -p 4 ./program -- N=150 A=1 B=2 
#1734545095
python generator.py -n 1000
#1734545099
ls
#1734545103
cat program.1285243.out
#1734545114
:q
#1734545133
mpixlc -o program test.c 
#1734545148
mpisubmit.pl -p 4 ./program -- N=150 A=A.out b=b.out 
#1734545149
cls
#1734545150
ls
#1734545151
clear
#1734545151
cls
#1734545157
ls
#1734545161
rm program.*
#1734545162
ls
#1734545177
mpisubmit.pl -p 4 ./program -- N=150 eps=0.001 A=A.bat b=b.bat 
#1734545179
ls
#1734545183
bjobs
#1734545185
ls
#1734545193
cat program.1285245.out 
#1734545198
cat program.1285245.err
#1734545207

#1734545470
vim run.sh
#1734545478
ls
#1734545479
run.sh
#1734545486
./run.sh
#1734545499
ls -l run.sh
#1734545514
chmod +x run.sh
#1734545516
ls -l run.sh
#1734545518
./run.sh
#1734545538
ls
#1734545542
rm N\=.1285270.
#1734545544
rm N*
#1734545546
ls
#1734545549
rm program*
#1734545550
ls
#1734545601
мшь к
#1734545605
vim run.sh 
#1734545643
./run.sh
#1734545649
./run.sh -p 4
#1734545652
./run.sh -p 4 -N 1000
#1734545656
./run.sh -p 4 -N 1000 -eps 0.001
#1734545665
./run.sh -p 4 -N 1000 -eps 0.001 -A A.bat -b b.bat 
#1734545676
./run.sh -p 4 -N 1000 -eps 0.001 -A A.bat -b b.bat -source test.c 
#1734545679
./run.sh -p 4 -N 1000 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734545681
ls
#1734545682
bjobs
#1734545684
ls
#1734545689
cat program.1285281.out
#1734545708
vim test.c 
#1734545726
cat program.1285281.err
#1734545739
vim test.c 
#1734545770
ls
#1734545773
vim test.c 
#1734545798
rm program*
#1734545803
./run.sh -p 4 -N 1000 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734545805
ls
#1734545806
bjobs
#1734545813
ls
#1734545817
cat program.1285292.err
#1734545819
cat program.1285292.out 
#1734545849
python generator.py 
#1734545863
python generator.py -n 150 -A A.bat -b b.bat
#1734545865
ls
#1734545890
clear
#1734545904
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546009
vim run.sh 
#1734546045
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546075
ls
#1734546079
rm program*
#1734546081
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546084
ls
#1734546088
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546094
rm program*
#1734546102
vim run.sh 
#1734546120
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546227
rm program*
#1734546229
vim run.sh 
#1734546245
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546317
vim run.sh 
#1734546338
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546389
vim run.sh 
#1734546416
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546456
vim run.sh 
#1734546640
ls
#1734546658
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546662
vim run.sh 
#1734546732
ls
#1734546733
clear
#1734546735
rm program*
#1734546163
cd prac/
#1734546164
ls
#1734546259
bjobs
#1734546261
ls
#1734546268
bjobs
#1734546276
ls
#1734546278
bjobs
#1734546350
rm
#1734546353
rm program*
#1734546364
ls
#1734546369
rm program*
#1734546369
ls
#1734546370
clear
#1734546438
ls
#1734546544
[A
#1734546560
vim run.sh 
#1734546598
ls
#1734546600
rm program*
#1734546624
./run.sh -p 4 -N 100 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546648
vim run.sh 
#1734546703
python generator.py 
#1734546707
python generator.py -n 125
#1734546713
./run.sh -p 4 -N 125 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546740
clear
#1734546747
vim generator.py 
#1734546790
python generator.py -n 125
#1734546792
ls
#1734546798
rm program*
#1734546799
ls
#1734546803
cat x.bat 
#1734546809
python generator.py -n 5
#1734546810
cat x.bat 
#1734546813
cat A.bat 
#1734546880
cat b.bat 
#1734546913
clear
#1734546918
./run.sh -p 4 -N 125 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734546921
ls
#1734546925
cat program.1285360.
#1734546926
cat program.1285360.out
#1734546942
clear
#1734546943
rm run.sh 
#1734546947
rm program*
#1734546953
python generator.py -n 125
#1734546975
mpisubmit.pl -p 4 ./program -- N=125 A=A.bat b=b.bat 
#1734546983
ls
#1734546986
cat program.1285363.err
#1734546988
cat program.1285363.out
#1734547012
chmod +x ./program
#1734547016
ды
#1734547017
ls
#1734547027
rm program.1285363.*
#1734547031
rm program*
#1734547032

#1734547041
mpixlc -o program test.c \
#1734547043
mpixlc -o program test.c 
#1734547050
module load SpectrumMPI
#1734547051
mpixlc -o program test.c 
#1734547057
mpisubmit.pl -p 4 ./program -- N=125 A=A.bat b=b.bat 
#1734547060
ls
#1734547064
cat program.1285369.err
#1734547077
mpisubmit.pl -p 4 ./program -- N=125 eps=0.1 A=A.bat b=b.bat 
#1734547082
rm program.128*
#1734547082
ls
#1734547084
mpisubmit.pl -p 4 ./program -- N=125 eps=0.1 A=A.bat b=b.bat 
#1734547085
ls
#1734547089
cat program.1285371.err
#1734547091
cat program.1285371.out
#1734547106
vim test.c 
#1734547195
cat x.bat 
#1734547565
сдуфк
#1734547566
clear
#1734547568
vim test.c 
#1734547986
cd ..
#1734547988
ls
#1734547990
cd edu-erv-vmsod24-02/
#1734547991
ls
#1734547992
clear
#1734547997
mv test.c prac/test.c
#1734547998
ls
#1734548000
cd prac/
#1734548006
mpixlc -o program test.c 
#1734548330
cd ..
#1734548334
mv test.c prac/test.c 
#1734548336
cd prac/
#1734548338
mpixlc -o program test.c 
#1734548351
./run.sh -p 4 -N 125 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734548365
mpisubmit.pl -p 4 ./program -- N=125 eps=0.001 A=A.bat b=b.bat 
#1734548371
ls
#1734548380
cat program.1285437.out
#1734548385
cat program.1285437.err
#1734548424
rm program*
#1734548425
cd ..
#1734548434
mv test.c prac/test.c
#1734548436
cd prac/
#1734548436
ls
#1734548445
python generator.py -N 125 
#1734548449
python generator.py -n 125
#1734548454
mpixlc -o program test.c 
#1734548463
mpisubmit.pl -p 4 ./program -- N=125 eps=0.001 A=A.bat b=b.bat 
#1734548464
ls
#1734548471
cat program.1285441.out
#1734548474
cat program.1285441.err
#1734548481
vim test.c 
#1734548493
mpisubmit.pl -p 4 ./program -- N=125 eps=0.001 A=A.bat b=b.bat 
#1734548495
rm program*
#1734548496
ls
#1734548497
rm program*
#1734548499
ls
#1734548504
mpixlc -o program test.c 
#1734548507
mpisubmit.pl -p 4 ./program -- N=125 eps=0.001 A=A.bat b=b.bat 
#1734548509
ls
#1734548514
cat program.1285444.err
#1734548530
ls
#1734548568
vim clear.sh
#1734548587
./cl
#1734548590
./clear.sh
#1734548604
chmod +x clear.sh
#1734548605
./clear.sh
#1734548607
ls
#1734548623
vim run.sh
#1734548659
chmod +x run.sh
#1734548662
./run.sh 
#1734548669
chmod +x run.sh
#1734548674
vim run.sh 
#1734548688
ls
#1734548693
./run.sh 
#1734548698
./run.sh -p 4
#1734548701
./run.sh -p 4 -N 125
#1734548704
./run.sh -p 4 -N 125 -eps 0.001
#1734548712
./run.sh -p 4 -N 125 -eps 0.001 -A A.bat -b b.bat
#1734548718
./run.sh -p 4 -N 125 -eps 0.001 -A A.bat -b b.bat -source test.c -program program
#1734548721
ls
#1734548729
cat program.1285453.err
#1734548733
cat program.1285453.o
#1734548736
csa
