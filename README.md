# Ubuntu 16.04 / PHP 7 / Nginx / MySQL 연동하기

## Ubuntu 16.04
#### 관리자 권한으로 작업
> sudo -s

#### Ubuntu 패키지 파일 업데이트
> apt update -y

```-y```는 설치과정 중 어떤 물음이든 ```Yes```를 응답한다는 뜻

#### Ubuntu 패키지 파일 업그레이드
> apt upgrade -y

```-y```는 설치과정 중 어떤 물음이든 ```Yes```를 응답한다는 뜻

---

## NginX
#### NginX 설치
> apt install nginx -y

```-y```는 설치과정 중 어떤 물음이든 ```Yes```를 응답한다는 뜻

#### NginX 설치 확인
> service nginx restart

웹 브라우저에서 ```127.0.0.1``` 접속했을 때 화면이 뜨면 설치확인 완료

#### NginX의 기본 설정 변경
> sudo vi /etc/nginx/sites-available/default

파일의 기본 작업 경로를 변경
> root /var/www/html
-> 원하는 경로로 변경

---

## PHP
#### PHP 패키지를 받아올 경로 추가
> add-apt-repository ppa:ondrej/php

> apt update -y

> apt upgrade -y


#### PHP 7.0 설치
> apt install php7.0 -y

---

## NginX와 PHP 연동
> apt install -y php7.0-fpm

#### 웹서버 접속했을 때 php 파일을 읽어올 수 있도록 설정 변경
> sudo vi /etc/nginx/sites-available/default

> index index.html index.htm index.nginx-debian.html 다음에 index.php 추가

---

## MySQL

#### 기본으로 필요한 MySQL 클라이언트, 서버 그리고 PhpMyadmin 설치
> apt install -y mysql-client mysql-server phpmyadmin php7.0-mysql php7.0-mbstring


#### PhpMyadmin 접속 설정
Nginx의 루트 작업 루트 경로로 심볼릭 링크를 바꿔준다
> ln -s /usr/share/phpmyadmin '루트 작업 경로'
