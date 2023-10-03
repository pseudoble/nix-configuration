declare -A pomo_options
pomo_options=( [work]="45" [break]="10" )

pomodoro () {
	if [ -n "$1" ] && [ -n "${pomo_options[$1]}" ]; then
		val="$1"
		echo $val | lolcat
		timer ${pomo_options[$val]}m
		spd-say "'$val session done'"
	fi
}

