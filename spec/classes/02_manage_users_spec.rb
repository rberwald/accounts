require 'spec_helper'

describe 'accounts' do
  describe 'accounts::manage_users' do

    describe 'Resource default settings' do
      let (:params) {{
        :users => {},
        :protect_system_users => false,
        :purge_groups => false,
        :purge_users => false,
        :signal_purge_only => false,
        :user_defaults => {},
        :groups => {},
        :group_defaults => {},
      }}

      it { should contain_resources('user').with( {
            'purge'              => false,
            'unless_system_user' => false,
            'noop'               => false,
          }
        )
      }
    end

    describe 'Single user as parameter' do
      let (:params) {{
        :users => {
          'u1' => {
            'home'       => '/some/path',
            'managehome' => true,
            'uid'        => '1234',
          }
        },
        :protect_system_users => false,
        :purge_groups => false,
        :purge_users => false,
        :signal_purge_only => false,
        :user_defaults => {},
        :groups => {},
        :group_defaults => {},
      }}

      it { should contain_user('u1').with( {
            'home'       => '/some/path',
            'managehome' => true,
            'uid'        => '1234',
          }
        )
      }
    end

    describe 'Multiple users as parameter' do
      let (:params) {{
        :users => {
          'u1' => {
            'home'       => '/some/path',
            'managehome' => true,
            'uid'        => '1234',
          },
          'u2' => {
            'home'       => '/some/path2',
            'managehome' => true,
            'uid'        => '1235',
          }
        },
        :protect_system_users => false,
        :purge_groups => false,
        :purge_users => false,
        :signal_purge_only => false,
        :user_defaults => {},
        :groups => {},
        :group_defaults => {},
      }}

      it { should contain_user('u1').with( {
            'home'       => '/some/path',
            'managehome' => true,
            'uid'        => '1234',
          }
        )
      }
      it { should contain_user('u2').with( {
            'home'       => '/some/path2',
            'managehome' => true,
            'uid'        => '1235',
          }
        )
      }
    end

    describe 'User settings merge with user defaults' do
      let (:params) {{
        :users => {
          'u1' => {
            'home'       => '/some/path',
            'managehome' => true,
            'uid'        => '1234',
            'shell'      => '/bin/bash',
          }
        },
        :protect_system_users => false,
        :purge_groups => false,
        :purge_users => false,
        :signal_purge_only => false,
        :user_defaults => {
          'password_max_age' => '98765',
          'shell'            => '/bin/sh',
        },
        :groups => {},
        :group_defaults => {},
      }}

      it { should contain_user('u1').with( {
            'home'             => '/some/path',
            'managehome'       => true,
            'uid'              => '1234',
            'password_max_age' => '98765',
            'shell'            => '/bin/bash',
          }
        )
      }
    end

    describe 'User with SSH key' do
      let (:params) {{
        :users => {
          'u1' => {
            'home'       => '/some/path',
            'uid'        => '1234',
            'ssh_key'   => {
              'mykey' => {
                'type' => 'ssh-rsa',
                'key'  => 'MyFakeKey',
              }
            }
          }
        },
        :protect_system_users => false,
        :purge_groups => false,
        :purge_users => false,
        :signal_purge_only => false,
        :user_defaults => {},
        :groups => {},
        :group_defaults => {},
      }}

      it { should contain_user('u1').with( {
            'home' => '/some/path',
            'uid'  => '1234',
          }
        )
      }

      it { should contain_ssh_authorized_key('mykey').with( {
            'user' => 'u1',
            'type' => 'ssh-rsa',
            'key'  => 'MyFakeKey',
          }
        )
      }
    end

    describe 'User with SSH key with user specified' do
      let (:params) {{
        :users => {
          'u1' => {
            'home'       => '/some/path',
            'uid'        => '1234',
            'ssh_key'   => {
              'mykey' => {
                'user' => 'luke',
                'type' => 'ssh-rsa',
                'key'  => 'MyFakeKey',
              }
            }
          }
        },
        :protect_system_users => false,
        :purge_groups => false,
        :purge_users => false,
        :signal_purge_only => false,
        :user_defaults => {},
        :groups => {},
        :group_defaults => {},
      }}

      it { should contain_user('u1').with( {
            'home' => '/some/path',
            'uid'  => '1234',
          }
        )
      }

      it { should contain_ssh_authorized_key('mykey').with( {
            'user' => 'u1',
            'type' => 'ssh-rsa',
            'key'  => 'MyFakeKey',
          }
        )
      }
    end

  end
end
