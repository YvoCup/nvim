return {
  cmd = { 'neocmakelsp', 'stdio' },
  filetypes = { 'cmake' },
  root_markers = { "build", "cmake", ".git" },
  init_options = {
    lint = {
      enable = false
    }
  }
}
