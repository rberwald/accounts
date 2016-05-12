require 'spec_helper'

describe 'accounts' do
  describe 'accounts' do
    let (:params) {{
      :users => {},
      :groups => {},
      :group_defaults => {},
      :protect_system_users => false,
      :purge_groups => false,
      :purge_users => false,
      :signal_purge_only => false,
      :user_defaults => {},
    }}

    it { should compile.with_all_deps }

    it { should contain_class('accounts::manage_groups') }
    it { should contain_class('accounts::manage_users') }
  end
end
