#accounts

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with accounts](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Testing - Ensure quality for PRs, etc.](#testing)
8. [Dependencies - Modules required to run](#dependencies)

##Overview

The accounts module configures groups and users.

##Module Description

The accounts module configures groups and users taken from Hiera, or given as a parameter.
The module uses the Data in Module features added in puppet 4.4 (PE 2016.1) to set defaults instead of using a params.pp file.

##Setup

###Beginning with accounts

Follow [this page](https://docs.puppet.com/puppet/latest/reference/lookup_quick_module.html) to setup your puppet server for data in modules.

Depending on how your setup is, you can now use:

`include '::accounts'` 

from anywhere.

```puppet
class { '::accounts':
  users => { ... },
}
```
from profile and roles.

Or add the class 'accounts' to you 'classes' array, if you use
```puppet
hiera_include('classes')
```

Specifying users will be done in hiera. An example:
```puppet
accounts::users:
  test1:
    ensure          : 'present'
    comment         : 'Example user
    gid             : '1000'
    groups          : ['test1']
    home            : '/home/test1'
    password        : '$6$evMMbifxTtJDKNy/mil740khsd7298fedsdcUcWNHaZtbVD.axWh0ZLN28M0'
    uid             : '1000'
    ssh_key:
      key1:
        type: 'ssh-rsa'
        key: 'AAAAFakeKeyDataXYZ=='
```
This will create an user 'test1' with a password.

##Usage

All interaction with the accounts module can be done through the main accounts class. This means you can simply toggle the options in `::accounts` to have full functionality of the module.


##Reference

###Classes

####Public Classes

* accounts: Main class, includes all other classes.

####Private Classes

* accounts::manage_groups: Handles the packages.
* accounts::manage_users: Handles the configuration file.

###Parameters

The following parameters are available in the `::accounts` class:

####`users`

Hash with the users to be managed.
Default value: '{}' (empty hash)

####`groups`

Hash with the groups to be managed.
Default value: '{}' (empty hash)

####`purge_users`

Specifies if unmanaged users should be purged from the system. Default value: 'false'


####`protect_system_users`

Specifies if system users should be protected from purging from the system. Default value: 'false'

####`purge_groups`

Specifies if unmanaged groups should be purged from the system. Default value: 'false'

####`signal_purge_only`

Specifies if purging of users and groups should be 'noop' operations. Default value: 'false'

####`user_defaults`

Default settings for all managed users. Default value:
```puppet
accounts::user_defaults:
  allowdupe        : false
  managehome       : true
  purge_ssh_keys   : true
  shell            : '/bin/bash'
  password_max_age : '99999'
  password_min_age : '0'
```

####`group_defaults`

Default settings for all managed groups. Default value:
```puppet
accounts::group_defaults:
  allowdupe : false
```

##Limitations

This module has should work on Posix [all PE-supported platforms](https://forge.puppetlabs.com/supported#compat-matrix), since it only calls the group and user resource, but has been tested only on RedHat and Ubuntu.

##Testing

Run `rspec` to double check tests pass.  

##Dependencies

The following modules are required:
* puppetlabs-stdlib
