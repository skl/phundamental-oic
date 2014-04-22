#!/bin/bash

case "${PH_OS}" in
"linux")
    case "${PH_OS_FLAVOUR}" in
    "debian")
        PH_OIC_UNINSTALL_CMD='dpkg -r'
        PH_OIC_UNINSTALL_SEARCH='dpkg -l'
        ;;

    "suse")
        PH_OIC_UNINSTALL_CMD='rpm -e'
        PH_OIC_UNINSTALL_SEARCH='rpm -qa'
        ;;

    *)
        echo "Instant Client installtion not implemented for this OS yet!"
        return 1 || exit 1
        ;;
    esac

    echo "You should run the following commands at your own risk:"
    for i in `${PH_OIC_UNINSTALL_SEARCH} | grep -i oracle`; do
        echo ${PH_OIC_UNINSTALL_CMD} ${i}
    done

    test ${PH_ARCH} == '32bit' && LIBDIR='client' || LIBDIR='client64'
    LIBDIR="/usr/lib/oracle/10.2.0.5/${LIBDIR}/lib"

    # Remove library path if exists
    ph_search_and_replace "${LIBDIR}" "" /etc/ld.so.conf
    ldconfig
    ;;

*)
    echo "Instant Client uninstallation not implemented for this OS yet!"
    return 1 || exit 1
    ;;
esac

