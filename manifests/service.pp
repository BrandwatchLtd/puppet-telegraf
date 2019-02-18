# == Class: telegraf::service
#
# Optionally manage the Telegraf service.
#
class telegraf::service {

  assert_private()

  if $::telegraf::manage_service {
    service { 'telegraf':
      ensure    => running,
      hasstatus => true,
      enable    => true,
      require   => Class['::telegraf::config'],
    }

    # This is a temporary thing just to ensure all servers get this cron removed if still existing, but this should be removed in the future also
    cron { 'ensure telegraf is listening on local ports':
      command => "bash -c '( ${tcp} && ${udp} ) || ${restart}' >/dev/null 2>&1",
      ensure  => 'absent'
    }
  }
}
