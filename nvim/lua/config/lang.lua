-- Reads DEVPOD_LANG env var (comma-separated list, e.g. "node,java")
-- and exposes M.has("node") for conditional plugin loading.
local M = {}
local _cache = nil

local function langs()
	if _cache then return _cache end
	_cache = {}
	local env = vim.env.DEVPOD_LANG or ""
	for l in env:gmatch("[^,]+") do
		_cache[l:lower():gsub("%s+", "")] = true
	end
	return _cache
end

function M.has(lang)
	return langs()[lang:lower()] == true
end

return M
