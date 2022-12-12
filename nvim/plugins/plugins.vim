" Calling vim-plug
call plug#begin()

" Airline + themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'preservim/nerdtree'
Plug 'andweeb/presence.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } "" Instalar FD pacman -S fd
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'xiyaowong/nvim-transparent'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'voldikss/vim-floaterm'
" themes 
Plug 'ellisonleao/gruvbox.nvim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'decaycs/decay.nvim', { 'as': 'decay' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" Loading Configs
source $HOME/.config/nvim/plugins/config/vim-airline.vim
source $HOME/.config/nvim/plugins/config/tokyonight-vim.vim
source $HOME/.config/nvim/plugins/config/bar-bar.vim 
source $HOME/.config/nvim/plugins/config/discord-presence.vim
source $HOME/.config/nvim/plugins/config/colorizer.vim
source $HOME/.config/nvim/plugins/config/treesiter.vim
source $HOME/.config/nvim/plugins/config/floatterm.vim
