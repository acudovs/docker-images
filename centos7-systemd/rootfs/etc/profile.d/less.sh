#
# DO NOT EDIT THIS FILE -- YOUR CHANGES WILL BE OVERWRITTEN BY DOCKER BUILD!
#

# less initialization script (sh)
export LESS="I M R"
[ -x /usr/bin/lesspipe.sh ] && export LESSOPEN="${LESSOPEN-||/usr/bin/lesspipe.sh %s}"
