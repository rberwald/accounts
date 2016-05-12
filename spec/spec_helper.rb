require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.hiera_config = 'hiera.yaml'
  c.default_facts = {
    :osfamily => 'RedHat',
    :operatingsystemmajrelease => '7',
  }
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!(95)
  end
end
