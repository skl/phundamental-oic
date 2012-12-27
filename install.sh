#!/bin/bash

case "${PH_OS}" in \
    "linux")
        for i in `ls -1 ${PH_INSTALL_DIR}/modules/oic/${PH_OS}/${PH_ARCH}/*.rpm`; do
            rpm -Uvh ${i}
        done

        test ${PH_ARCH} == '32bit' && LIBDIR='client' || LIBDIR='client64'
        LIBDIR="/usr/lib/oracle/10.2.0.5/${LIBDIR}/lib"

        # Append new library if not already there
        grep "${LIBDIR}" /etc/ld.so.conf >/dev/null || echo "${LIBDIR}" >> /etc/ld.so.conf && ldconfig
    ;;

    *)
        echo "Instant Client installtion not implemented for this OS yet!"
esac
