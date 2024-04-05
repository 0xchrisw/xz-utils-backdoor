#!/bin/bash

# Install a few tools
apt-get install rpm2cpio cpio

# Download the xz-5.6.1-1.fc41.src.rpm file
wget https://kojipkgs.fedoraproject.org/packages/xz/5.6.1/1.fc41/src/xz-5.6.1-1.fc41.src.rpm

# Extract the contents of the RPM package
rpm2cpio xz-5.6.1-1.fc41.src.rpm | cpio -idmv

# Extract the xz-5.6.1.tar.gz file
mkdir xz_source
tar -xzvf xz-5.6.1.tar.gz -C xz_source

# Assign a few variables
top_srcdir="xz_source/xz-5.6.1/"
p="good-large_compressed.lzma"
N=0
W=88664
i="((head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +2048 && (head -c +1024 >/dev/null) && head -c +939)";

# Extract the file
xz -dc $top_srcdir/tests/files/$p | \
eval $i | \
LC_ALL=C sed "s/\(.\)/\1\n/g" | \
LC_ALL=C awk 'BEGIN{FS="\n";RS="\n";ORS="";m=256;for(i=0;i<m;i++){t[sprintf("x%c",i)]=i;c[i]=((i*7)+5)%m;}i=0;j=0;for(l=0;l<8192;l++){i=(i+1)%m;a=c[i];j=(j+a)%m;c[i]=c[j];c[j]=a;}}{v=t["x" (NF<1?RS:$1)];i=(i+1)%m;a=c[i];j=(j+a)%m;b=c[j];c[i]=b;c[j]=a;k=c[(a+b)%m];printf "%c",(v+k)%m}' | \
xz -dc --single-stream | \
((head -c +$N > /dev/null 2>&1) && head -c +$W) > liblzma_la-crc64-fast.o

# Display the extracted file
file liblzma_la-crc64-fast.o
