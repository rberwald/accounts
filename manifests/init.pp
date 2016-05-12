# This class creates and manages users and groups on your systems.
# All data is taken from Hiera, with defaults in the
# hieradata directory inside the module
#
# @example when using it from hiera
#   classes:
#     - accounts
#
#   accounts::user_defaults:
#     managehome : true
#     allowdupe : false
#     password_max_age: 99999
#     password_min_age: 0
#     purge_ssh_keys: true
#     shell : '/bin/bash'
#
#   accounts::users:
#     test_user:
#       uid : 1234
#       gid : 'test_user'
#       groups:
#         - wheel
#         - sudo
#       home : '/home/test_user'
#       ssh_key:
#         key1:
#           type: 'ssh-rsa'
#           key: 'AAAAFakeKeyDataXYZ=='
#
#   accounts::group_defaults:
#     allowdupe: false
#
#   accounts::groups:
#     test_user:
#       gid : 1234
#
# @param users The hash of users to be managed
# @param groups The hash of groups to be managed
# @param purge_users If not managed users should be purged (boolean)
# @param protect_system_users If system users should be protected from purging (boolean)
# @param purge_groups If not managed groups should be purged (boolean)
# @param signal_purge_only If purging users or groups should be a noop operation (boolean)
# @param user_defaults The hash with default user settings
# @param group_defaults The has with default group settings
#
class accounts (
  Hash    $users,
  Hash    $groups,
  Boolean $purge_users,
  Boolean $protect_system_users,
  Boolean $purge_groups,
  Boolean $signal_purge_only,
  Hash    $user_defaults,
  Hash    $group_defaults,
) {

  # Manage all accounts we want to manage
  class { 'accounts::manage_groups':
    purge_groups      => $purge_groups,
    signal_purge_only => $signal_purge_only,
    group_defaults    => $group_defaults,
    groups            => $groups,
  }

  class { 'accounts::manage_users':
    purge_users          => $purge_users,
    protect_system_users => $protect_system_users,
    signal_purge_only    => $signal_purge_only,
    user_defaults        => $user_defaults,
    users                => $users,
  }
}
