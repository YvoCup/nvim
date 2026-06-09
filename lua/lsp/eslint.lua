local lsp = vim.lsp

local function insert_package_json(files, field, bufname)
  local res = vim.list_extend({}, files)
  local dir = vim.fn.fnamemodify(bufname, ':h')
  local pkg = vim.fs.find('package.json', { path = dir, upward = true, limit = 1 })[1]
  if pkg then
    -- 用 vim.json.decode 读 package.json
    local ok, data = pcall(function()
      return vim.json.decode(table.concat(vim.fn.readfile(pkg), '\n'))
    end)
    if ok and data[field] then
      table.insert(res, pkg)
    end
  end
  return res
end

local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}

return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
    'svelte',
    'astro',
    'htmlangular',
  },
  workspace_required = true,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspEslintFixAll', function()
      client:request_sync('workspace/executeCommand', {
        command = 'eslint.applyAllFixes',
        arguments = {
          {
            uri = vim.uri_from_bufnr(bufnr),
            version = lsp.util.buf_versions[bufnr],
          },
        },
      }, nil, bufnr)
    end, {})
  end,
  root_dir = function(bufnr)
    -- 1. 排除 deno
    if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' }) then
      return nil
    end

    local filename = vim.api.nvim_buf_get_name(bufnr)
    if filename == '' then return nil end -- 无名缓冲区

    -- 2. 找项目根
    local root_markers = {
      'package-lock.json',
      'yarn.lock',
      'pnpm-lock.yaml',
      'bun.lockb',
      'bun.lock',
      '.git',
    }
    local project_root = vim.fs.root(bufnr, root_markers)
    if not project_root then
      project_root = vim.fn.getcwd()
    end

    -- 3. 是否存在 eslint 配置（含 package.json 里的 eslintConfig）
    local files = insert_package_json(eslint_config_files, 'eslintConfig', filename)
    local has_config = vim.fs.find(files, {
      path = filename,
      upward = true,
      stop = vim.fs.dirname(project_root),
      type = 'file',
      limit = 1,
    })[1]

    return has_config and project_root or nil
  end,
  -- Refer to https://github.com/Microsoft/vscode-eslint#settings-options for documentation.
  settings = {
    validate = 'on',
    ---@diagnostic disable-next-line: assign-type-mismatch
    packageManager = nil,
    useESLintClass = false,
    experimental = {
      useFlatConfig = true,
    },
    codeActionOnSave = {
      enable = false,
      mode = 'all',
    },
    format = true,
    quiet = false,
    onIgnoredFiles = 'off',
    rulesCustomizations = {},
    run = 'onType',
    problems = {
      shortenToSingleLine = false,
    },
    -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
    -- This path is relative to the workspace folder (root dir) of the server instance.
    nodePath = '',
    -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
    workingDirectory = { mode = 'auto' },
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = 'separateLine',
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
  before_init = function(_, config)
    -- The "workspaceFolder" is a VSCode concept. It limits how far the
    -- server will traverse the file system when locating the ESLint config
    -- file (e.g., .eslintrc).
    local root_dir = config.root_dir

    if root_dir then
      config.settings = config.settings or {}
      config.settings.workspaceFolder = {
        uri = root_dir,
        name = vim.fn.fnamemodify(root_dir, ':t'),
      }

      -- Support flat config files
      -- They contain 'config' in the file name
      local flat_config_files = vim.tbl_filter(function(file)
        return file:match('config')
      end, eslint_config_files)

      for _, file in ipairs(flat_config_files) do
        local found_files = vim.fn.globpath(root_dir, file, true, true)

        -- Filter out files inside node_modules
        local filtered_files = {}
        for _, found_file in ipairs(found_files) do
          if string.find(found_file, '[/\\]node_modules[/\\]') == nil then
            table.insert(filtered_files, found_file)
          end
        end

        if #filtered_files > 0 then
          config.settings.experimental = config.settings.experimental or {}
          config.settings.experimental.useFlatConfig = true
          break
        end
      end

      -- Support Yarn2 (PnP) projects
      local pnp_cjs = root_dir .. '/.pnp.cjs'
      local pnp_js = root_dir .. '/.pnp.js'
      if type(config.cmd) == 'table' and (vim.uv.fs_stat(pnp_cjs) or vim.uv.fs_stat(pnp_js)) then
        config.cmd = vim.list_extend({ 'yarn', 'exec' }, config.cmd --[[@as table]])
      end
    end
  end,
  handlers = {
    ['eslint/openDoc'] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,
    ['eslint/confirmESLintExecution'] = function(_, result)
      if not result then
        return
      end
      return 4 -- approved
    end,
    ['eslint/probeFailed'] = function()
      vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
      return {}
    end,
    ['eslint/noLibrary'] = function()
      vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
      return {}
    end,
  },
}
