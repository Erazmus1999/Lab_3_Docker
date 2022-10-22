FROM alpine
 #tworzenie obrazu alpine

WORKDIR /usr/app 

EXPOSE 8080 
#wystawienie portu 8080 (port forwarding)

RUN apk add --update nodejs npm #instalacja paczek

RUN apk add --update npm

RUN apk add openssh

RUN apk add git

RUN mkdir -p /root/.ssh
 #tworzenie folderu z kluczem

RUN touch /root/.ssh/id_rsa 
# tworzenie plików z kluczami

RUN touch /root/.ssh/id_rsa.pub

RUN touch /root/.ssh/known_hosts

RUN ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

RUN chmod 600 /root/.ssh/id_rsa
 #zmiana uprawnień zapis + odczyt

RUN chmod 600 /root/.ssh/id_rsa.pub

COPY ./id_rsa.pub /root/.ssh/id_rsa.pub 
#kopia z windowsa na linuxa

COPY ./id_rsa /root/.ssh/id_rsa

RUN chmod 400 /root/.ssh/id_rsa 
#tylko odczyt

RUN chmod 400 /root/.ssh/id_rsa.pub

RUN touch /root/.ssh/config 
#plik konfiguracyjny dla kluczy

RUN chmod 700 /root/.ssh/config

RUN echo $'Host git \n HostName github.com \n AddKeysToAgent yes \n PreferredAuthentications publikey \n IdentityFile /root/.ssh/id_rsa' > /root/.ssh/config

RUN git clone git@github.com:Erazmus1999/Docker_1.git .
#klon repozytorium

RUN npm -g outdated

RUN npm -g update
#update paczek
RUN npm install
#instalacja serwera
CMD npm start
#odpalenie serwera po włączeniu kontenera