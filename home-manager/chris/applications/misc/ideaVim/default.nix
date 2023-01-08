{ lib, pkgs, ... }:
{
  home.file.".ideavimrc".text = ''
    let mapleader = " "
    set clipboard+=unnamed        -- use system clipboard
    set scrolloff = 15            -- keep 15 row buffer on screen edges
    set relativenumber = true     -- show relative distance between rows
    set hlsearch = false          -- remove highlighting after search
    set number = true             -- show current line number
    set NERDTree                  -- enable vim controls in file tree
    set highlightedyank           -- briefly hightlight copied text
    set visualbell                -- disable audio bell
  '';
}
