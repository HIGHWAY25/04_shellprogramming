배시 쉘 프로그래밍

1. 선수 지식

1) 명령어
	grep CMD
	
		# grep OPTIONS PATTERNS file1
		OPTIONS: -i, -v, -l, -n, -r, -w
		PATTERNS: *  .  ^root  root$ [abc]  [a-c]  [^a]
	sed CMD
	
		p CMD) # sed -n '1,3p' /etc/hosts
		d CMD) # sed '1,3d' /etc/hosts
		s CMD) # sed -i '/main/s/192.168.10.10/192.168.10.20/' /etc/hosts
	awk CMD
	
		# awk 'statement {action}' filename
		# awk -F: '$3 >= 1000 && $3 <= 60000 {print $1}' /etc/passwd 
		# df -h / | tail -1 | awk '{print $6}' | awk -F% '{print $1}'
		# ifconfig eth0 | grep inet | grep -v inet6 | awk '{print $2}' | awk -F: '{print $2}'
		# ps -elf | awk '$2 == "Z" {print $0}'
	+
	CMD(sort CMD, cut CMD, ....)
	
2) 쉘의 특성
3) 
	* Redirection(<, 0<, >, 1>, >>, 1>>, 2>, 2>>)
	* Pipe(|)
	* Variable
	* Metachracter('', "", ``, ;)
	* History
	* Alias
	* Function
		(선언) fun() {CMD; CMD;}
		(실행) fun
		(확인) typeset -f
		(해제) unset -f fun
	* Environment File(s) (/etc/profile, ~/.bash_profile, ~/.bashrc)
	* cat CMD + <<
	* Grouping
	* &&, ||
		-A && B
		-A && B || C
		-A || B
	* dirname/basename CMD
	* eval CMD + other CMD
	
2. Shell Script/Shell Programming

1) 프로그램 작성과 실행
	# bash -x script.sh
	# . ~/.bashrc
	# vi script.sh ; chmod +x script.sh ; ./script.sh
	# vi script.sh ; chmod =X script.sh ; ./script.sh
	[참고] 매직넘버(#!/bin/bash)

2) 주석처리
	* 한줄 주석	- #
	* 여러줄 주석	- : << EOF ~ EOF
	
3) 입력 & 출력
	출력: echo CMD, print f CMD
	입력: read CMD

4) 산술연산
	더하기)expr 1 + 2
	빼기	)expr 3 - 1
	곱하기)expr 3 \* 3
	나누기)expr 10 / 2
	나머지)expr 10 % 3
	
5) 조건문: if 문, case 문
	* if 문
		if 조건; then
			statement1
		elif 조건; then
			statement2
		else
			statement3
		fi
	# case 문
		case VAR in
			조건1) statement1 ;;
			조건2) statement2 ;;
			*) statement3 ;;
		esac
	
6) 반복문: for 문, while 문

	* for 문: for 문 + seq CMD
		for var in var_list
		do
			statement
		done
	* while 문: while 문 + continue/break/shift
		while 조건(condition)
		do
			statement
		done
7) 함수 

	선언)
		fun(){ CMD; CMD; }
		function fun { CMD; CMD; }
	실행)	fun
	확인)	typeset -f
	해제)	unset -f fun
	
	함수입력: 인자($1, $2, $3, ...)
	함수출력: echo $RET
	
8) I/O 리다이렉션과 자식 프로세스

	for LINE in $(cat file1)
	do
		echo $LINE
	done > file2
	
	cat file1 | while read LINE
	do
		echo $LINE
	done > file2
	
	(비추천)	
	while read LINE
	do
		echo $LINE
	done < file1 > file2
		
9) 시그널 제어(Signal Trap)

	* 시그널 무시
	* 시그널 받으면 개발자 원하는 동작
	
10) 디버깅

	* bash -x script.sh
	* bash -xv script.sh
	
11) 옵션처리

	getopts CMD + while CMD + case CMD
	(예) # ssh.sh -p 80 192.168.10.20
	while getopts p: options
	do
		case $options in
			p ) P_ACTION ;;
			\?) Usage	 ;;
			*)	Usage	 ;;
		esac
	done
	
	shift $(expr $OTIND - 1)
	if [ $# -ne 1 ] ; then
		Usage
	fi
	echo "$# : $@"
	
vscode 자동으로 켜지도록 설정
* crontab + vskill.sh

kill $(ps -ef | grep code | grep -v 'grep --color' \
| awk '{print $2}' |sort | head -1)
------------------------------
partition

LV (PV -> VG -> LV)
filesystem
mount
------------------------------
./lvm.sh
------------------------------
PV 작업
------------------------------
보기
--------------
선택(ex: /dev/sdb1 /dev/sdc1 ....)?
	# pvcreate /dev/sda1 /dev/sdb1 /dev/sdc1
	fdisk -l | grep LVM | awk '{print $1}' > pv1.txt
	pvs | tail -n +2 | awk '{print $1}' > pv2.txt
	cat pv1.txt pv2.txt | sort | uniq -u
-> 작업
------------------------------
VG 작업
------------------------------
보기
--------------
선택(ex: ....)
	vgs | tail -n +2 | awk '{print $1}'

-> 작업
------------------------------
LV 작업
------------------------------
보기
--------------
선택(ex: ...)
-> 작업
12) 파일이름 자동 변환 스크립트

13) 환경 설정 스크립트

ENV1.sh: 환경설정
	* $HOME/.bash_profile
ENV2.sh: 필요한 패키지 설치
	* 패키지 설치(gcc, ,php ,vscode, chrome)
ENV3.sh: 서버 세팅
	* telnet 서버(root 사용자 접속 가능)
		# yum -y install telnet telnet-server
		# systemctl enable telnet.sockets
	* ftp 서버(root 사용자 접속 가능)
		# yum -y install vsftpd ftp
		# sed -i 's/^root #root/' /etc/vsftpd/ftpusers
		# sed -i 's/^root #root/' /etc/vsftpd/user_list
		# systemctl enable --now vsftpd.service
	* ssh 커버(root 사용자 접속 가능)
		# yum -y install openssh-server openssh-clients openssh
		# sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
		# sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
		# sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
		# sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
		# systemctl enable --now sshd.service
	* ngnix web 서버(index.html)
		# yum -y install ngnix
		# echo "Nginx WebServer" > /usr/share/nginx/html/index.html
		# systemctl enable --now nginx.service
	
	

rpm --import https://packages.microsoft.com/keys/microsoft.asc

cat <<EOF > /etc/yum.repos.d/vscode.repo'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gphcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc"
EOF
	
yum localinstall google-chrome-stable_current_x86_64.rpm
yum localinstall /root/bin/aa.rpm
	
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -O /root/bin/aa.rpm
	

