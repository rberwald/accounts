# For documentation, see init.pp
class accounts::manage_users (
  Boolean $purge_users,
  Boolean $protect_system_users,
  Boolean $signal_purge_only,
  Hash $user_defaults,
  Hash $users,
) {

  # Purge all unmanaged groups, including system groups,
  resources { 'user':
    purge              => $purge_users,
    unless_system_user => $protect_system_users,
    noop               => $signal_purge_only,
  }

  # Create each user
  $users.each |String $user_name, Hash $user_attr| {

    # If SSH keys are given, create them
    if $user_attr['ssh_key'] {
      # lint:ignore:variable_scope
      $user_attr['ssh_key'].each |String $_key_name, Hash $_key_value| {
        $__key_value = delete($_key_value, 'user')
        ssh_authorized_key { $_key_name:
          user => $user_name,
          *    => $__key_value,
        }
      }
      # lint:endignore
    }
    # Remove the SSH keys
    $_user_attr = delete($user_attr, 'ssh_key')

    user { $user_name:
      * => $user_defaults + $_user_attr,
    }
  }

}
