#!/usr/bin/env bash
# written by cat-marin
# depends on maim/slop and ffmpeg
# Copyright © 2020 cat-marin
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# default config (to be expanded later)
# DATE=$(date "+%F-%H-%M-%S")
# start config
CONFIGDIR="$HOME/.config/rec.sh"
CONFIG="$CONFIGDIR/config"
source $CONFIG
# end config

help_func() {
cat << EOF
written by cat-marin (see license within $0)
  -h  | --help : display this help text
  -m1 | --mp4  : record selection and output to '~/$CONFIGDIR/mp4/rec.sh-DATE.mp4'
  -g  | --gif  : record selection and output to '~/$CONFIGDIR/gif/rec.sh-DATE.gif'
EOF
}

mp4() {
    SLOP=$(slop -f '|%wx%h|%x,%y')
    RES=$(echo $SLOP | cut -d "|" -f 2)
    XGRAB=$(echo $SLOP | cut -d "|" -f 3)
    mkdir -p $CONFIGDIR/mp4
    ffmpeg -video_size $RES -framerate 25 -f x11grab -i :0.0+$XGRAB -c:v libx264 -pix_fmt yuv420p -preset ultrafast -crf 22 -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" $CONFIGDIR/mp4/rec.sh-$DATE.mp4
    echo "$CONFIGDIR/mp4/rec.sh-$DATE.mp4"
}

gif() {
    SLOP=$(slop -f '|%wx%h|%x,%y')
    RES=$(echo $SLOP | cut -d "|" -f 2)
    XGRAB=$(echo $SLOP | cut -d "|" -f 3)
    mkdir -p $CONFIGDIR/gif
    ffmpeg -video_size $RES -framerate 15 -f x11grab -i :0.0+$XGRAB $CONFIGDIR/gif/rec.sh-$DATE.gif
    echo "$HOME/.rec/gif/rec.sh-$DATE.gif"
}

for arg in "$@"; do
	case $arg in
		-h|--help)
			help_func
		;;
		-m1|--mp4)
			mp4
		;;
		-g|--gif)
			gif
		;;
	esac
done
if [[ "$@" == "" ]]; then
	help_func
fi
