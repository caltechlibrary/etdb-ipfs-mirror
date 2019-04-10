#!/bin/bash

export IPFS_PATH=/raid/ipfs

while read hash; do
    date
    # The timeout is needed because ipfs will hang until content is
    # downloaded.  If a server or the network or something else is hung up
    # (e.g., the only node with the content is unavailable) then it will hang
    # indefinitely.
    timeout --signal=SIGQUIT --kill-after=31m 30m  ipfs get "/ipfs/$hash"
    retval=$?
    if [ $retval -eq 0 ]; then
        # In principle, we could avoid the ipfs get and only do the ipfs pin
        # here, but ipfs pin prints no message at all while it's working and
        # thus it is difficult to find out if anything is happening.  With
        # ipfs get, it prints a progress bar and some statistics, and those
        # are useful for our purposes.  The ipfs pin command here will take
        # almost no time once the content is gotten via ipfs get.
        ipfs pin add "/ipfs/$hash"
    else
        echo "Timed out trying to get $hash"
    fi
    /bin/rm -rf "$hash"
done < "hashes"
