class tse_admins (
  $purge = true,
) {

  $tses = hiera_hash('tse_admins')

  create_resources('tse_admins::user', $tses)

  if $purge {
    resources { 'user':
      purge              => true,
      unless_system_user => true,
    }
  }


  group { 'tseadmin':
    ensure => present,
  }

}
