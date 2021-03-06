#!/bin/sh

for ruby in \
 1.8.7-p374\
 1.9.3-p551\
 2.1.5\
 2.2.0\
 2.2.1
do
    echo "\n********************************************************************************"
    echo "Building $ruby\n"
    cd ext/oj
    rbenv local $ruby
    ruby extconf.rb
    make

    echo "\nRunning tests for $ruby"
    cd ../../test
    rbenv local $ruby
    cd isolated
    rbenv local $ruby
    cd ..
    ./test_all.sh
    cd ..

    echo "\n"
done

PATH=/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin:$PATH
echo "\n********************************************************************************"
echo "Building OS X Ruby\n"
cd ext/oj
ruby extconf.rb
make

echo "\nRunning tests for OS X Ruby"
cd ../../test
./test_all.sh
cd ..

echo "\n"
