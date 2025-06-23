vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>cl", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set({ "i", "n" }, "<C-x>", "<ESC>:wq<CR>", { desc = "save and exit" })

-- keymaps similar to vs code
keymap.set({ "i", "n" }, "<C-s>", "<ESC>:w<CR>", { desc = "save with Ctrl + s" }) -- save with ctrl + s
keymap.set({ "i" }, "jf", "<ESC>:wq<CR>", { desc = "save with j+f" })             -- save with j + s
keymap.set({ "i", "n" }, "<C-z>", "<ESC>u", { desc = "undo" })                    -- undo with ctrl + z
keymap.set({ "i", "n" }, "<C-y>", "<C-r>", { desc = "redo" })                     -- redo with ctrl + y


-- Delete a word backwards
keymap.set("n", "dw", 'vb"_di')
keymap.set("n", "<C-d>", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- window management
keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })                    -- split window vertically
keymap.set("n", "<leader>h", "<C-w>s", { desc = "Split window horizontally" })                  -- split window horizontally
keymap.set("n", "<leader>ee", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
keymap.set("n", "<leader>ex", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<C-n>", "<cmd>tabn<CR>", { desc = "Go to next tab" })                          --  go to next tab
keymap.set("n", "<C-p>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                      --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
