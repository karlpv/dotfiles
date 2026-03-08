-- ~/.config/nvim/lua/plugins/flash.lua


---@param opts any
local function format(opts)
  return {
    { opts.match.label1, "FlashMatch" },
    { opts.match.label2, "FlashLabel" },
  }
end

local function two_label_jump_word_start()
  local Flash = require("flash")

  Flash.jump({
    search = { mode = "search" },
    label = {
      after = false,
      before = { 0, 0 },
      uppercase = false,
      format = format,
    },
    pattern = [[\<]],
    action = function(match, state)
      state:hide()
      Flash.jump({
        search = { max_length = 0 },
        highlight = { matches = false },
        label = { format = format },

        matcher = function(win)
          return vim.tbl_filter(function(m)
            return m.label == match.label and m.win == win
          end, state.results)
        end,

        labeler = function(matches)
          for _, m in ipairs(matches) do
            m.label = m.label2
          end
        end,
      })
    end,

    labeler = function(matches, state)
      local labels = state:labels()
      for i, m in ipairs(matches) do
        m.label1 = labels[math.floor((i - 1) / #labels) + 1]
        m.label2 = labels[(i - 1) % #labels + 1]
        m.label = m.label1
      end
    end,
  })
end

return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",

    -- Put your "always on Ctrl+S search" stuff here safely (no require needed)
    opts = {
      modes = {
        search = {
          enabled = false, -- Flash search always on
        },
      },
    },

    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "gw", mode = { "n", "x", "o" }, two_label_jump_word_start, desc = "Flash (2-label word start)" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}
