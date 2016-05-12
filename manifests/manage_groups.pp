# For documentation, see init.pp
class accounts::manage_groups (
  Boolean $purge_groups,
  Boolean $signal_purge_only,
  Hash $group_defaults,
  Hash $groups,
) {

  # Purge all unmanaged groups, including system groups,
  resources { 'group':
    purge => $purge_groups,
    noop  => $signal_purge_only,
  }

  $groups.each |String $group_name, Hash $group_attr| {
    group { $group_name:
      * => $group_defaults + $group_attr,
    }
  }

}
