#!/bin/bash

case "${PH_OS}" in \
    "linux")
        for i in `rpm -qa | grep -i oracle`; do
            rpm -e ${i}
        done

        test ${PH_ARCH} == '32bit' && LIBDIR='client' || LIBDIR='client64'
        LIBDIR="/usr/lib/oracle/10.2.0.5/${LIBDIR}/lib"

        # Remove library path if exists
        ph_search_and_replace "${LIBDIR}" "" /etc/ld.so.conf
        ldconfig

        echo ""
        echo "Uninstalled all RPMs matching 'oracle'."
    ;;

    *)
        echo "Instant Client uninstallation not implemented for this OS yet!"
esac

