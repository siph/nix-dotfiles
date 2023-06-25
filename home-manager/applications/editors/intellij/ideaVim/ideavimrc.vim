" I wish I were in NeoVim
" Vim Settings
let mapleader=" "             " spacebar as leader key
set clipboard+=unnamed        " use system clipboard
set scrolloff=15              " keep 15 row buffer on screen edges
set relativenumber            " show relative distance between rows
set number                    " show current line number
set visualbell                " disable audio bell
set ignorecase                " case-insensitive search
set smartcase                 " smart searching

" IdeaVim Settings
set ideajoin                  " line concatenation
set ideawrite=file            " `:w` behavior

" Mappings
nmap gqq :action com.andrewbrookins.idea.wrap.WrapAction<CR>
vmap gq :action com.andrewbrookins.idea.wrap.WrapAction<CR>

nmap <leader>w <Action>(SaveDocument)

nmap <leader>lr <Action>(RenameElement)
nmap <leader>ld <Action>(QuickImplementations)
nmap <leader>lh <Action>(QuickJavaDoc)
nmap <leader>la <Action>(ShowIntentionActions)

nmap <leader>fg <Action>(FindInPath)
nmap <leader>ff <Action>(GotoFile)

nmap <leader>ghr <Action>(Vcs.RollbackChangedLines)
nmap <leader>ghd <Action>(Compare.SameVersion)

nmap <leader>b <Action>(CloseEditor)

" Plugins
set NERDTree                  " enable vim controls in file tree
set highlightedyank           " briefly highlight copied text
set commentary                " vim style comment/uncomment
