function gitnuke --wraps='git reset --hard && git clean -fd' --description 'Nukes the current directory Git worktree with git reset --hard && git clean -fd'
  git reset --hard && git clean -fd
end
