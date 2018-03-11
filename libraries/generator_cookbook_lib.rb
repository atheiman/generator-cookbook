module ChefDK
  module Command
    module GeneratorCommands
      class Cookbook < Base
        def emit_post_create_message
          msg(
            "Thank you for using https://github.com/atheiman/generator-cookbook." \
            "\nYour cookbook is ready. Type `cd #{cookbook_name_or_path}` to enter it." \
            "\nThere are several commands you can run to get started locally developing and testing your cookbook." \
            "\nWhy not start by writing a test? Tests for the default recipe are stored at:" \
            "\n\ttest/integration/default/default_spec.rb" \
            "\nIf you'd prefer to dive right in, the default recipe can be found at:" \
            "\n\trecipes/default.rb\n"
          )
        end
      end
    end
  end
end
