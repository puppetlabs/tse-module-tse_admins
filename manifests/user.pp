define tse_admins::user (
  String $username = $title,
  String $longname,
  Array  $groups   = 'tseadmin',
  String $shell    = '/bin/bash',
  $sshkeys,
) {

  include tse_admins::groups

  $groups.each |String $group| {
    if defined(Group[$group]) {
      realize(Group[$group])
    }
  }

  # we are specific about this users setup
  user { $username:
    ensure         => present,
    home           => "/home/${username}",
    managehome     => true,
    comment        => "${longname}'s Account created by tse_admins module",
    forcelocal     => true,
    groups         => $groups,
    purge_ssh_keys => true,
    shell          => $shell,
  }

  # make sure we have puppet in the path in the bashrc, but don't do anything else
  file_line { "${username}_puppet_path":
    ensure  => present,
    line    => 'PATH=$PATH:/opt/puppet/bin/',
    path    => "/home/${username}/.bashrc",
    require => User[$username],
  }

  # since you can put an array of ssh keys, we are making this possible to easily install N number keys
  tse_admins::keys { $sshkeys:
    username => $username,
  }
}
