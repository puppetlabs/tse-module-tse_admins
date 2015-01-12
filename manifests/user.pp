define tse_admins::user (
  $username = $title,
  $longname,
  $group = 'tseadmin',
  $shell = '/bin/bash',
  $sshkeys,
) {

  user { $username:
    ensure         => present,
    managehome     => true,
    comment        => "${longname}'s Account created by tse_admins module",
    forcelocal     => true,
    groups         => $group,
    purge_ssh_keys => true,
    shell          => $shell,
  }

  file_line { "${username}_puppet_path":
    ensure  => present,
    line    => 'PATH=$PATH:/opt/puppet/bin/',
    path    => "/home/${username}/.bashrc",
    require => User[$username],
  }

  tse_admins::keys { $sshkeys:
    name => $username,
    type => 'ssh-rsa',
  }



}
