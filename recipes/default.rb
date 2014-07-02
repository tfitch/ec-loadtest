#
# Cookbook Name:: ec-loadtest
# Recipe:: default
#
# Author:: Tyler Fitch <tfitch@getchef.com>
# Copyright 2014 Chef Software, Inc. <legal@getchef.com>
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'jenkins::java'
include_recipe 'jenkins::master'

# maybe not the latest and greatest versions...
package 'maven'
package 'git'
package 'ruby'
gem_package 'thor'


# git plugin dependencies first
jenkins_plugin 'scm-api' do
	version '0.2'
end
jenkins_plugin 'git-client' do
	version '1.9.1'
end
# https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin - git - 2.2.2
jenkins_plugin 'git' do
	version '2.2.2'
end
# https://wiki.jenkins-ci.org/display/JENKINS/Gatling+Plugin - gatling - 1.0.3
jenkins_plugin 'gatling' do
	version '1.0.3'
	notifies :restart, 'service[jenkins]', :immediately
end

# our script to setup the Chef headers for a Gatling script
# sourced from https://gist.github.com/jeremiahsnapp/7251930
cookbook_file '/usr/local/bin/GatlingChef.rb' do
	owner 'jenkins'
	group 'jenkins'
	mode '0755'
end

# create our POC job
xml = File.join(Chef::Config[:file_cache_path], 'poc-config.xml')
cookbook_file xml do
	source 'test-ec-metal-job-config.xml'
end
jenkins_job 'test-ec-metal' do
	config xml
end


# ec-metal hack to hit testing server
hostsfile_entry '33.33.33.23' do
  hostname  'api.opscode.piab'
  action    :create_if_missing
end