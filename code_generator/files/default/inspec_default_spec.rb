describe file('/etc/some.config') do
  its('owner') { should eq 'root' }
  its('mode') { should cmp '0600' }
  its('content') { should eq('key = value') }
end
