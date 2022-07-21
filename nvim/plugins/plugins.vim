" Calling vim-plug
call plug#begin()

" Airline + themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdtree'
Plug 'andweeb/presence.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } "" Instalar FD pacman -S fd

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" themes 
Plug 'ellisonleao/gruvbox.nvim'
Plug 'ghifarit53/tokyonight-vim'

call plug#end()

" Loading Configs
source $HOME/.config/nvim/plugins/config/vim-airline.vim
source $HOME/.config/nvim/plugins/config/tokyonight-vim.vim
source $HOME/.config/nvim/plugins/config/bar-bar.vim 
source $HOME/.config/nvim/plugins/config/discord-presence.vim
source $HOME/.config/nvim/plugins/config/colorizer.vim
