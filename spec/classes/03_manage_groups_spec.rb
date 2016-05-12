require 'spec_helper'

describe 'accounts' do
  describe 'accounts::manage_groups' do

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

      it { should contain_resources('group').with( {
            'purge'              => false,
            'noop'               => false,
          }
        )
      }
    end

    describe 'Single group as parameter' do
      let (:params) {{
        :users => {},
        :protect_system_users => false,
        :purge_groups => false,
        :purge_users => false,
        :signal_purge_only => false,
        :user_defaults => {},
        :groups => {
          'g1' => {
            'allowdupe' => false,
            'gid' => '4321',
          }
        },
        :group_defaults => {},
      }}

      it { should contain_group('g1').with( {
            'gid'        => '4321',
            'allowdupe'  => false,
          }
        )
      }
    end

    describe 'Multiple groups as parameter' do
      let (:params) {{
        :users => {},
        :protect_system_users => false,
        :purge_groups => false,
        :purge_users => false,
        :signal_purge_only => false,
        :user_defaults => {},
        :groups => {
          'g1' => {
            'allowdupe' => false,
            'gid' => '4321',
          },
          'g2' => {
            'allowdupe' => false,
            'gid' => '4325',
          }
        },
        :group_defaults => {},
      }}

      it { should contain_group('g1').with( {
            'gid'        => '4321',
            'allowdupe'  => false,
          }
        )
      }

      it { should contain_group('g2').with( {
            'gid'        => '4325',
            'allowdupe'  => false,
          }
        )
      }
    end

    describe 'Group settings merge with group defaults' do
      let (:params) {{
        :users => {},
        :protect_system_users => false,
        :purge_groups => false,
        :purge_users => false,
        :signal_purge_only => false,
        :user_defaults => {},
        :groups => {
          'g1' => {
            'gid'        => '4321',
            'forcelocal' => false,
          }
        },
        :group_defaults => {
          'allowdupe'  => false,
          'forcelocal' => true,
        },
      }}

      it { should contain_group('g1').with( {
            'gid'        => '4321',
            'allowdupe'  => false,
            'forcelocal' => false,
          }
        )
      }

    end

  end
end
