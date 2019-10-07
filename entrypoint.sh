#!/bin/bash
TOOLS_DIR=/opt/$USER/tools
exec /opt/$USER/git/odoo/odoo-bin -c  /opt/$USER/tools/odoo.conf

create_serverrc () {
    # Create .openerp_serverrc file
    echo -n "Creating ~/.odoorc file... "
    if [ ! -e ~/.odoorc ]; then
        echo "OK"
    else
        echo "File exists!"
    fi
}

exec ls





# if [ ! -f git/sfl/tools/bin/start_odoo ]; then
#     git config --global user.name 'Docker Container'
#     git config --global user.email 'support@savoirfairelinux.com'
#     git/sfl/tools/dev.sh || return 1
# fi

# sed -i '/db_host/d' git/sfl/tools/etc/dev.cfg
# if [ -d /opt/$USER/ENV ]; then
#     cd ENV
#     source bin/activate
#     cd ..
# fi


# case $1 in
#     start_odoo)
# 	shift
# 	git/odoo/odoo-bin $@
# 	;;
#     env)
# 	echo "Entering interactive mode..."
# 	bash -l
# 	;;
#     *)
# 	echo "Unknow command!"
# 	echo "$@"
# 	echo
# 	echo "Usage:"
# 	echo
# 	echo "docker-compose -f tools/docker-compose.yml run --service-ports odoo [command] [args]"
# 	echo
# 	echo "Where command can be:"
# 	echo "   start_odoo | upgrade_odoo [odoo args]"
# 	echo "   dev.sh | lab.sh | prod.sh"
# 	echo
# 	;;
# esac
