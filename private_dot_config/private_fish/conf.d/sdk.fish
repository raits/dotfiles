function _check_sdkrc --on-variable PWD --description 'Check for .sdkmanrc and start env if present'
  status --is-command-substitution; and return

  # Initialize the current_sdk_env variable if it doesn't exist
  if test -z "$current_sdk_env" 
    set -g current_sdk_env ""
  end

  # Check if .sdkmanrc exists and is not the current environment
  if test -e .sdkmanrc; and test $current_sdk_env != $PWD
    set -g current_sdk_env $PWD 
    echo ".sdkmanrc detected, starting environment"
    sdk env
  # Check if .sdkmanrc doesn't exist but is in the current environments path
  else if not test -e .sdkmanrc; and test -n "$current_sdk_env"; and test $current_sdk_env = (string sub --length (string length $current_sdk_env) $PWD)
    #echo "Already in .sdkmanrc environment $current_sdk_env"
  # Check if .sdkmanrc doesn't exist and is not in the current environments path
  else if test -n "$current_sdk_env"
    # Need to do this manually since the Fish integration for SDKMAN doesn't support this
    echo 'Left .sdkmanrc environment, resetting to default'
    for line in (cat $current_sdk_env/.sdkmanrc)
      #echo "Processing line: $line"
      if test -z "$line"; or test (string sub --length 1 $line) = "#"
        #echo "Skipping line: $line"
        continue
      end
      set -lu line_parts = (string split = $line)
      #echo "Line parts are: $line_parts"
      #echo "Setting $line_parts[2] to $line_parts[3]"
      if test (count $line_parts) -eq 3
        set -lu candidate_dir = (path normalize (string join '/' $SDKMAN_CANDIDATES_DIR (string trim $line_parts[2]) 'current'))
        #echo "Checking for $candidate_dir"
        set -lu default_version (readlink $candidate_dir)
        #echo "Default version is $default_version"
        if test -n "$default_version"
          #echo "Setting $line_parts[2] to $default_version"
          sdk use (string trim $line_parts[2]) (string trim $default_version)
        end
      end
    end
    set -g current_sdk_env ""
  end
end
