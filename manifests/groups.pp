class tse_admins::groups {
  @group { 'tseadmin': ensure => present, gid => 600 }
}
