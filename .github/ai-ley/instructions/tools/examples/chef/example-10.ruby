# cookbooks/enterprise_cicd/recipes/default.rb
# Comprehensive CI/CD pipeline integration

# Test Kitchen configuration for cookbook testing
directory node['test_kitchen']['config_path'] do
  owner node['test_kitchen']['user']
  group node['test_kitchen']['group']
  mode '0755'
  recursive true
  action :create
end

template "#{node['test_kitchen']['config_path']}/.kitchen.yml" do
  source 'kitchen.yml.erb'
  owner node['test_kitchen']['user']
  group node['test_kitchen']['group']
  mode '0644'
  variables({
    driver: node['test_kitchen']['driver'],
    platforms: node['test_kitchen']['platforms'],
    suites: node['test_kitchen']['suites'],
    provisioner: node['test_kitchen']['provisioner']
  })
end

# ChefSpec unit testing framework
gem_package 'chefspec' do
  version node['testing']['chefspec']['version']
  action :install
end

gem_package 'rspec' do
  version node['testing']['rspec']['version']
  action :install
end

# Foodcritic linting
gem_package 'foodcritic' do
  version node['testing']['foodcritic']['version']
  action :install
end

gem_package 'rubocop' do
  version node['testing']['rubocop']['version']
  action :install
end

# Cookstyle (Chef's Ruby style guide)
gem_package 'cookstyle' do
  version node['testing']['cookstyle']['version']
  action :install
end

# InSpec compliance testing
gem_package 'inspec' do
  version node['testing']['inspec']['version']
  action :install
end

# Berkshelf dependency management
gem_package 'berkshelf' do
  version node['dependency_management']['berkshelf']['version']
  action :install
end

template "#{node['test_kitchen']['config_path']}/Berksfile" do
  source 'Berksfile.erb'
  owner node['test_kitchen']['user']
  group node['test_kitchen']['group']
  mode '0644'
  variables({
    cookbook_sources: node['dependency_management']['cookbook_sources'],
    dependencies: node['dependency_management']['dependencies']
  })
end

# Jenkins build agent configuration
if node['cicd']['jenkins']['enabled']
  include_recipe 'jenkins::java'

  jenkins_slave node['jenkins']['slave']['name'] do
    description "Chef cookbook testing agent - #{node['hostname']}"
    remote_fs node['jenkins']['slave']['home']
    executors node['jenkins']['slave']['executors']
    labels node['jenkins']['slave']['labels']
    usage_mode 'exclusive'
    availability 'always'
    env node['jenkins']['slave']['environment_variables']
    jvm_options node['jenkins']['slave']['jvm_options']

    # Credential configuration
    slave_user node['jenkins']['slave']['user']
    slave_password node['jenkins']['slave']['password']

    # Connection configuration
    master_url node['jenkins']['master']['url']
    master_username node['jenkins']['master']['username']
    master_password node['jenkins']['master']['password']
  end
end

# GitLab CI runner configuration
if node['cicd']['gitlab']['enabled']
  package 'gitlab-runner' do
    action :install
  end

  execute 'register_gitlab_runner' do
    command lazy {
      "gitlab-runner register " \
      "--non-interactive " \
      "--url #{node['gitlab']['url']} " \
      "--registration-token #{node['gitlab']['runner_token']} " \
      "--executor shell " \
      "--description 'Chef Enterprise Runner - #{node['hostname']}' " \
      "--tag-list '#{node['gitlab']['runner_tags'].join(',')}''"
    }
    not_if 'gitlab-runner verify'
    sensitive true
  end

  service 'gitlab-runner' do
    action [:enable, :start]
  end
end

# Automated cookbook testing pipeline
template '/usr/local/bin/chef-test-pipeline.sh' do
  source 'chef-test-pipeline.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables({
    cookbook_path: node['chef']['cookbook_path'],
    test_results_path: node['testing']['results_path'],
    notification_webhook: node['testing']['notification_webhook'],
    quality_gates: node['testing']['quality_gates']
  })
end

# Cookbook deployment automation
template '/usr/local/bin/chef-deploy-cookbook.sh' do
  source 'chef-deploy-cookbook.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables({
    chef_server_url: node['chef_server']['url'],
    deployment_environments: node['deployment']['environments'],
    approval_required: node['deployment']['approval_required'],
    rollback_enabled: node['deployment']['rollback_enabled']
  })
end

# Policy-based deployment with Policyfiles
if node['chef']['policyfile']['enabled']
  gem_package 'chef-dk' do
    action :install
  end

  template "#{node['chef']['repo_path']}/Policyfile.rb" do
    source 'Policyfile.rb.erb'
    owner node['chef']['user']
    group node['chef']['group']
    mode '0644'
    variables({
      policy_name: node['chef']['policyfile']['name'],
      run_list: node['chef']['policyfile']['run_list'],
      cookbook_sources: node['chef']['policyfile']['cookbook_sources'],
      attributes: node['chef']['policyfile']['attributes']
    })
  end

  execute 'install_policyfile' do
    command 'chef install'
    cwd node['chef']['repo_path']
    user node['chef']['user']
    environment 'HOME' => node['chef']['home_path']
    subscribes :run, "template[#{node['chef']['repo_path']}/Policyfile.rb]", :immediately
  end
end