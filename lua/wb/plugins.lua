
local install_path = ("%s/site/pack/packer-lib/opt/packer.nvim"):format(vim.fn.stdpath "data")

local function install_packer()
    vim.fn.termopen(("git clone https://github.com/wbthomason/packer.nvim %q"):format(install_path))
end


if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    install_packer()
end


vim.cmd.packadd { "packer.nvim" }

function _G.packer_upgrade()
    vim.fn.delete(install_path, "rf")
    install_packer()
end

vim.cmd.command { "PackerUpgrade", ":call v:lua.packer_upgrade()", bang = true }

local function spec(use)
	  use { "lewis6991/impatient.nvim" }

	use{
	   "rebelot/kanagawa.nvim",
	   "kyazdani42/nvim-web-devicons",
	   "lukas-reineke/headlines.nvim",
	   "lukas-reineke/indent-blankline.nvim",
           "NvChad/nvim-colorizer.lua",
	}	
	
	use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

	 -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "p00f/nvim-ts-rainbow",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "windwp/nvim-ts-autotag",
        }
    }

	use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
	}

	use {'ms-jpq/coq_nvim', branch = "coq" }
	use { 'ms-jpq/coq.artifacts', branch = "artifacts" }
	use { 'ms-jpq/coq.thirdparty', branch  = "3p" }
end


require("packer").startup {
    spec,
    config = {
        max_jobs = vim.fn.has "win32" == 1 and 5 or nil,
    },
}

