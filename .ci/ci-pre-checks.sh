#!/bin/bash
#  This file is part of cc-oci-runtime.
#
#  Copyright (C) 2017 Intel Corporation
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

#---------------------------------------------------------------------
# Description: Perform basic checks on the branch before attempting
#   to run the build and test suites. If this script fails, the CI run
#   will be aborted.
#---------------------------------------------------------------------

if [ "$TRAVIS" = true ]
then
    repo="github.com/clearcontainers/tests/cmd/checkcommits"
    go get -d "$repo"
    (cd "$GOPATH/src/$repo" && make)
    checkcommits \
        --need-fixes \
        --need-sign-offs \
        --body-length 72 \
        --subject-length 75 \
        --verbose
fi
