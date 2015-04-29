class tse_admins::groups {
  @group { 'tseadmin': ensure => present, gid => 600 }
  @group { 'foo':      ensure => present, gid => 601 }
  @group { 'bar':      ensure => present, gid => 602 }
  @group { 'foobar':   ensure => present, gid => 603 }
}
