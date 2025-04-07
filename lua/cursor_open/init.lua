local M = {}

-- デフォルト設定
local defaults = {
    keymaps = {
        open = '<leader>oc',
        open_new = '<leader>oC',
    },
}

-- 設定
local config = {}

-- Git リポジトリルートを取得する関数
local function get_git_root(path)
    local result = vim.fn.system('git -C ' .. vim.fn.shellescape(path) .. ' rev-parse --show-toplevel 2>/dev/null')
    if vim.v.shell_error ~= 0 then
        return nil
    end
    return result:gsub('\n', '')
end

-- 現在のファイルを Cursor で開く
local function open_in_cursor(opts)
    opts = opts or {}
    local force_new = opts.bang or false

    local file_path = vim.fn.expand('%:p')
    local line_num = vim.fn.line('.')
    local col_num = vim.fn.col('.')

    -- Git リポジトリルートを取得（可能な場合）
    local git_root = get_git_root(vim.fn.expand('%:p:h'))

    local cursor_args = {}

    -- フラグの設定
    if force_new then
        table.insert(cursor_args, '-n') -- 新しいウィンドウを強制
    elseif git_root then
        -- 強制フラグがない場合は既存のワークスペースを再利用
        table.insert(cursor_args, '-r')
    end

    -- ワークスペースとファイルの設定
    if git_root then
        table.insert(cursor_args, git_root)
    end

    -- ファイル位置の指定
    table.insert(cursor_args, '-g')
    table.insert(cursor_args, string.format('%s:%s:%s', file_path, line_num, col_num))

    -- コマンドの実行
    local cmd = 'cursor ' .. table.concat(cursor_args, ' ')
    local job_id = vim.fn.jobstart(cmd, { detach = true })

    if job_id <= 0 then
        vim.notify('Cursorの起動に失敗しました', vim.log.levels.ERROR)
    end
end

-- プラグインの初期化
function M.setup(opts)
    -- デフォルト設定とユーザー設定のマージ
    config = vim.tbl_deep_extend('force', defaults, opts or {})

    -- CursorOpen コマンドの作成
    vim.api.nvim_create_user_command('CursorOpen', function(cmd_opts)
        open_in_cursor({ bang = cmd_opts.bang })
    end, { bang = true })

    -- キーマッピングの設定
    if config.keymaps.open then
        vim.keymap.set('n', config.keymaps.open, ':CursorOpen<CR>',
            { desc = 'Open in Cursor', noremap = true, silent = true })
    end

    if config.keymaps.open_new then
        vim.keymap.set('n', config.keymaps.open_new, ':CursorOpen!<CR>',
            { desc = 'Open in Cursor (new window)', noremap = true, silent = true })
    end
end

return M
