#!/usr/bin/env bash


[[ $- != *i* ]] && return;

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}



[[ -f ~/.extend.bashrc ]] && . ~/.extend.bashrc;

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion;

transfer() {
    if [ $# -eq 0 ]; then
        echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
        return 1;
    fi

    tmpfile=$( mktemp -t transferXXX );

    if tty -s; then
        basefile=$(basename "$1" | sed -e s/[^a-zA-Z0-9._-]/-/g);
        curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
    else
        curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
    fi;

    cat $tmpfile;
    rm -f $tmpfile;
}

yt2mp3() {
    if [ $# -lt 1 ]; then 
        echo "[ERROR] USAGE: $0 YOUTUBE_URL"
        return;
    fi;
    if [ -e /usr/local/bin/youtube-dl ] && [ -x /usr/local/bin/youtube-dl]; then
    	/usr/local/bin/youtube-dl --extract-audio --audio-format mp3 $1;
    else
        youtube-dl --extract-audio --audio-format mp3 $1;
    fi;
}




# export LESSOPEN="| ~/.lessfilter %s";
# export LESS=' -R ';
