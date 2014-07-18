#
# Cookbook Name:: cookbook_rubybox
# Recipe:: ruby
#
# Install and setup Ruby environment
#

if node['cookbook_rubybox']['ruby']['versions'].count == 0

  include_recipe "ruby_build::default"
  ruby_build_ruby node['cookbook_rubybox']['ruby']['global_version']

else

  include_recipe "rbenv::default"
  include_recipe "rbenv::ruby_build"

  node['cookbook_rubybox']['ruby']['versions'].each do |rb_version|

    rbenv_ruby rb_version do
      global(node['cookbook_rubybox']['ruby']['global_version'] == rb_version)
    end
    rbenv_gem 'bundler' do
      ruby_version rb_version
    end

  end

end
