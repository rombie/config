# Copyright 2012-2013 Hewlett-Packard Development Company, L.P.
# Copyright 2014 OpenContrail Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# == Class: zuul::merger
#
class zuul::merger (
) {
  service { 'zuul-merger':
    name       => 'zuul-merger',
    enable     => true,
    hasrestart => true,
    require    => File['/etc/init.d/zuul-merger'],
  }

  cron { 'zuul_repack':
    user        => 'zuul',
    hour        => '4',
    minute      => '7',
    command     => 'find /var/lib/zuul/git/ -maxdepth 3 -type d -name ".git" -exec git --git-dir="{}" pack-refs --all \;',
    environment => 'PATH=/usr/bin:/bin:/usr/sbin:/sbin',
    require     => [User['zuul'],
                    File['/var/lib/zuul/git']],
  }
}
