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

#### php7.0-fpm 작동 상태 확인
> service php7.0-fpm status

---

## MySQL

#### 기본으로 필요한 MySQL 클라이언트, 서버 그리고 PhpMyadmin 설치
> apt install -y mysql-client mysql-server phpmyadmin php7.0-mysql php7.0-mbstring


#### PhpMyadmin 접속 설정
Nginx의 루트 작업 루트 경로로 심볼릭 링크를 바꿔준다
> ln -s /usr/share/phpmyadmin '루트 작업 경로'


---
## VSFTP와 Atom을 이용해서 개발 작업하기
터미널을 통해서 AWS/Azure에 SSH 접속할 경우 CLI환경에서 작업할 수 밖에없다.<br>
 작업에 불편함을 느껴서 다른 방법을 알아보던 중 FTP로 pc에 접속해서 작업을 하는 것을 적용하기로 했다.

#### VSFTP 설치
> sudo apt install vsftpd

설치 후 설정을 변경해줘야 한다.

#### 설정 파일 열기
> $ sudo vi /etc/vsftpd.conf

나는 혼자서 실습할 용도라서 딱 필요한 부분만 건드렸다.
`chroot_local_user=YES`, `allow_writeable_chroot=YES`

아래 설정 값들 중 필요한 값을 설정해준다.
```
// anonymous 유저 사용 불가
anonymous_enable=NO

// 계정사용자 접속 가능
local_enable=YES

// 업로드 가능
write_enable=YES

// 디렉토리나 파일 생성시 umask 값
local_umask=022

// 접속시 메세지
ftpd_banner=Welcome to uzuro FTP service

// 접속시 출력 메세지 설정 ( shell등을 이용해 접속시 )
// 사용자 홈디렉토리에 .message 파일에 작성
dirmessage_enable=YES

// chroot 적용
// 아래와 같은 설정을 할 경우 사용자들은 자신의 계정에서 상위 디렉토리로 이동할수 없게된다. chroot_local_user=YES

// 특정 사용자만을 Jail 설정할 경우
// chroot_list에 등록되어있는 계정에만 chroot가 적용 chroot_list_enable=YES chroot_list_file=/etc/vsftpd/chroot_list

// 특정 사용자를 제외한 나머지 사용자만을 Jail 설정할 경우
// chroot_list에 등록된 계정을 제외한 나머지가 자신의 계정에 chroot가 걸림 chroot_local_user=YES chroot_list_enable=YES chroot_list_file=/etc/vsftpd/chroot_list

// 계정마다 동적으로 설정할 경우
// 아래와 같이 설정을 하게 되면 /etc/passwd 파일을 참고하여 jail 설정을 할 수 있게 됨
// /etc/passwd 파일을 수정하여 경로에 .을 찍게 되면 그 지점이 chroot지점이 됨
// theeye:x:600:100::/home/./theeye:/bin/bash
chroot_local_user=YES
passwd_chroot_enable=YES
```

#### FTP 디렉토리 변경
FTP 접속할 경우 접근 할 디렉토리를 변경한다.
```
//디렉토리 생성
sudo mkdir /home/test

//FTP 유저의 홈디렉토리 변경
sudo usermod -d /home/test ftp

//재시작
sudo restart vsftpd
```

#### FTP 작업 폴더의 접근 권한 변경하기
VSFTP 설치가 끝났다고해서 작업을 할 수는 없다.
해당 디렉토리에 대한 접근권한이 없기 때문이다.

`chmod` 명령을 이용해서 접근권한을 설정해준다.
우선 FTP 작업 폴더가 있는 곳으로 이동한다
```
cd ~
또는
cd /home
```

그 후 `ls -al` 명령을 실행한다.

그럼 아래의 형태로 결과가 나올 것이다(결과값이 다를수는 있다. 구성요소만 보면 된다.)
```
total 1
drwxr-xr-x 1 root root 4096 1 Nov test
```

d : 파일 타입
- d : 디렉토리
- l : 링크 파일
- \- : 일반 파일

rwxr-xr-x : 접근 권한
- r : 읽기 권한, `chmod`명령 사용시 `r` 대신 `4`를 입력해도 된다
- w : 쓰기 권한, `chmod`명령 사용시 `w` 대신 `2`를 입력해도 된다
- x : 실행 권한, `chmod`명령 사용시 `x` 대신 `1`을 입력해도 된다
- 각 값은 비트(bit)로도 권한 값을 조절할 수 있다.

예를 들어
\``chmod 755 test`는 test 파일(디렉터리)에 755권한을 주겠다\`라는 뜻이다.<br>
여기서 755 권한이란 위에서 설명한 r, w, x권한 각각의 값이다.<br>
7 = 4 + 2 + 1 이므로 r, w, x 권한이 모두 있는 것이고<br>
5 = 4 + 1 이므로 r, x 권한만 있는 것이다

왜 5일때 r, x권한이 있는지는 각각의 값을 조합해보면 `r`과 `x`권한밖에 못넣는다는 것을 알 수 있다.

username username : 소유자, 소유 그룹
첫번째 username은 소유자 두번째 username은 소유 그룹을 나타낸다.

<br><br>
일반적으로 관리자, 공동작업자는 7(rwx)의 권한 줘서 모든 작업을 가능하게 하고, 이외의 사용자는 권한을 주지 않거나 5(rx)권한만 준다.<br>

나는 `test` 디렉터리에 755권한을 주기로 했다.
> chmod 755


#### Atom의 FTP 패키지 설치하기
Atom 에디터에서 [remote-ftp 패키지](https://github.com/icetee/remote-ftp)를 설치해야한다.

[]한 사용자의 블로그](http://recoveryman.tistory.com/242)에 설명이 잘 되어 있지만 문제점이 있다.

포스팅에는 21번 포트로 ftp 접속을 하고 있다.
하지만 Atom에디터의 remote-ftp 패키지는 22번 포트로 sftp접속만 되는것을 확인했다. [FileZilla](https://filezilla-project.org/)을 이용해서 21번 포트 ftp접속을 시도하면 가능하긴 하다. 하지만 **Active**모드에서만 접속이 된다. remote-ftp 패키지에서 접속 모드를 선택할 수 있는 옵션은 없으므로 22번포트 sftp로 접속을 한다.

참고 : [FTP접속 시 Active 모드, Passive 모드에 대한 설명](http://mintnlatte.tistory.com/407)
<br>
변경되는 부분은 아래의 내용을 참고하면 된다.
<br>
블로그의 설명을 보고 따라하되 설정(config)값은 바꿔준다.
```
{
    "protocol": "sftp",
    "host": "호스트_주소_입력(서버의 IP 또는 주소)",
    "port": 22,
    "user": "유저이름_입력(해당 서버로 접속하려는 계정이름)",
    "pass": "비밀번호_입력(해당 서버로 접속하려는 계정의 비밀번호)",
    "promptForPass": false,
    "remote": /home/test/ "경로_입력(해당 서버에 접속을 원하는 경로)",
    "secure": false,
    "secureOptions": null,
    "connTimeout": 10000,
    "pasvTimeout": 10000,
    "keepalive": 10000,
    "watch": []
}
```

여기까지 따라했다면 기본적인 서버 세팅은 끝나게 된다.


+ 만약 ftp 접속이 안된다면 방화벽 실행중인지 그리고 22번 포트가 막혀있지는 않은지 확인한다.
