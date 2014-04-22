#!/bin/bash

case "${PH_OS}" in
"linux")
    case "${PH_OS_FLAVOUR}" in
    "debian")
        PH_OIC_UNINSTALL_CMD="dpkg -r"
        PH_OIC_UNINSTALL_SEARCH="`dpkg -l | grep oracle-instantclient | awk '{print \$2}'`"
        ;;

    "suse")
        PH_OIC_UNINSTALL_CMD="rpm -e"
        PH_OIC_UNINSTALL_SEARCH="`rpm -qa | grep oracle-instantclient`"
        ;;

    *)
        echo "Instant Client installtion not implemented for this OS yet!"
        return 1 || exit 1
        ;;
    esac

    for i in ${PH_OIC_UNINSTALL_SEARCH}; do
        ${PH_OIC_UNINSTALL_CMD} ${i}
    done

    rm -iv /etc/ld.so.conf.d/oracle-instantclient.conf
    ldconfig
    ;;

*)
    echo "Instant Client uninstallation not implemented for this OS yet!"
    return 1 || exit 1
    ;;
esac

