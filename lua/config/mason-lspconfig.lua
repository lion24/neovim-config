local M = {}

function M.setup()
	ensure_installed = { "sumneko_lua", "bash-language-server" }
	automatic_installation = true
end

return M
