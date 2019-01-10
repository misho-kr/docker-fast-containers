#!/bin/bash
#----------------------------------------------------------------------

WORKDIR=${PWD}/mysql

#----------------------------------

function mysql_up() {
	docker-compose -f ${WORKDIR}/container.yml up
}

function mysql_down() {
	docker-compose -f ${WORKDIR}/container.yml down
}

#----------------------------------

#----------------------------------------------------------------------
# end
#
