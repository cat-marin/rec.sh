# rec.sh
A simple recording script using ffmpeg and slop. 

# Dependencies
- ffmpeg
- libx264
- slop

# Installation
For now, there is no installation script (likely won't be, it's only a bash script). However, here's how the "install" goes:
1. If you don't already have one, make something like a `~/.bin` (hereafter referred to as `$BINDIR`) directory and add it to your user's path.
2. Copy rec.sh into `$BINDIR`.
3. **Before** running `rec.sh`, create `~/.config/rec.sh` (hereafter referred to as `$CONFIGDIR`) and copy the default config (contained at the beginning of the `rec.sh` file) to `$CONFIGDIR/config`.
4. Read the output of `rec.sh -h`, right now `rec.sh` is incredibly simple, but I might add more features in the future.
