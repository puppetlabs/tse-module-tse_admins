class tse_admins (
  $purge = true,
) {

  #$groups = hiera_hash('tse_admins::groups')
  #create_resources('@group', $groups)

  $tses = hiera_hash('tse_admins')
  create_resources('tse_admins::user', $tses)

  if $purge {
    resources { 'user':
      purge              => true,
      unless_system_user => true,
    }
  }

  $preserved_users = hiera_array('preserved_users')
  user { $preserved_users:
    ensure => present,
  }

  #group { 'tseadmin':
  #  ensure => present,
  #}

}
