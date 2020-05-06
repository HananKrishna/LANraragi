#!/bin/sh

#Just do everything 
apk update 
apk add perl perl-io-socket-ssl perl-dev redis libarchive-dev libbz2 openssl-dev zlib-dev 
apk add imagemagick imagemagick-perlmagick libwebp-tools
apk add g++ make pkgconf gnupg wget curl nodejs nodejs-npm
apk add supervisor su-exec shadow

#Hey it's cpanm
curl -L https://cpanmin.us | perl - App::cpanminus 

#Install the LRR dependencies proper
cd tools && cpanm --notest --installdeps . -M https://cpan.metacpan.org && cd ..
npm run lanraragi-installer install-front 

#Cleanup to lighten the image
apk del perl-dev g++ make gnupg wget curl nodejs nodejs-npm openssl-dev zlib-dev libarchive-dev 
rm -rf /root/.cpanm/* /root/.npm/* /usr/local/share/man/* node_modules