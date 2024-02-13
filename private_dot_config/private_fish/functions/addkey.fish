function addkey --wraps='keychain --eval id_rsa | source' --description 'alias addkey=keychain --eval id_rsa | source'
  keychain --eval id_rsa | source $argv
        
end
