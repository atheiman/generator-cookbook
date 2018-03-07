require 'spec_helper'

describe 'generated_cookbook::default' do
  # let(:something) { 'something' }

  context 'some context' do
    cached(:chef_run) do
      # ChefSpec::ServerRunner.new do |node, server|
      #   node.set['generated_cookbook']['some_attribute'] = 'some value'
      #   server.create_data_bag(
      #     'my_data_bag',
      #     'item_1' => { 'password' => 'abc123' }
      #   )
      # end.converge(described_recipe)
      ChefSpec::ServerRunner.new.converge(described_recipe)
    end

    it do
      expect(chef_run).to create_file('/etc/some.config').with(
        owner: 'root',
        mode: '600'
      )
    end

    it do
      expect(chef_run).to render_file('/etc/some.config').with_content('key = value')
    end
  end
end
