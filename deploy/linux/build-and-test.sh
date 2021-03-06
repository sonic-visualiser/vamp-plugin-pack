#!/bin/bash
#
# Docker required

set -eu

case $(git status --porcelain --untracked-files=no) in
    "") ;;
    *) echo "ERROR: Current working copy has been modified - unmodified copy required so we know we can check it out separately and obtain the same contents"; exit 2;;
esac

current=$(git rev-parse --short HEAD)

echo
echo "Building appimage from revision $current..."

dockerdir=deploy/linux/docker

cat "$dockerdir"/Dockerfile.in | \
    perl -p -e "s/\[\[REVISION\]\]/$current/g" > \
         "$dockerdir"/Dockerfile.gen

cat "$dockerdir"/Dockerfile_test.in | \
    perl -p -e "s/\[\[REVISION\]\]/$current/g" > \
         "$dockerdir"/Dockerfile_test.gen

fgrep 'hg.sr.ht' ~/.ssh/known_hosts > "$dockerdir"/known_hosts
cp ~/.ssh/id_rsa_build "$dockerdir"/id_rsa_build
chmod 600 "$dockerdir"/known_hosts "$dockerdir"/id_rsa_build
trap "rm $dockerdir/known_hosts $dockerdir/id_rsa_build" 0

dockertag="cannam/vamp-plugin-pack-installer-$current"

sudo docker build -t "$dockertag" -f "$dockerdir"/Dockerfile.gen "$dockerdir"

outdir="$dockerdir/output"
mkdir -p "$outdir"

container=$(sudo docker create "$dockertag")

sudo docker cp "$container":output.tar "$outdir"
sudo docker rm "$container"

( cd "$outdir" ; tar xf output.tar && rm -f output.tar )

sudo docker build -f "$dockerdir"/Dockerfile_test.gen "$dockerdir"
