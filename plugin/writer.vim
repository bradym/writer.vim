" Vim plugin for writing prose
" Last Change:	2011-08-02
" Maintainer:	Honza Pokorny <me@honza.ca>
" License:	BSD license

if exists("g:loaded_writer")
    finish
endif

let g:loaded_writer = 1
let g:writer_on = 0

let s:save_cpo = &cpo
set cpo&vim

let s:font = escape(&guifont, " ")
let s:numbers = &number
let s:relative = &relativenumber
let s:spacing = &linespace
let s:cursor = &cursorline
let s:width = &textwidth
let s:status = &laststatus
let s:foldcolumn = &foldcolumn

function s:Toggle()
    if has('gui')
        if (g:writer_on == 0)

            " Set font
            set guifont=Monaco:h15

            " Kill line numbers
            set nonumber
            set norelativenumber

            " Line spacing
            set linespace=5

            " Don't highlight the current line
            set nocursorline

            " Maximum line length.
            set textwidth=75

            " Hide the status line
            set laststatus=0

            " Set a left margin so text isn't squished against the left edge.
            set foldcolumn=2

            " More natural navigation for writing
            nnoremap j gj
            nnoremap k gk
            vnoremap j gj
            vnoremap k gk

            " Turn on spell check
            set spell

            " Enable writegood mode - requires https://github.com/davidbeckingsale/writegood.vim
            if exists('g:loaded_writegood')
                call writegood#enable()
            endif

            " Store the plugin status
            let g:writer_on = 1
        else
            exe ":set guifont=" . s:font
            exe ":set linespace=" . s:spacing
            exe ":set textwidth=" . s:width
            exe ":set laststatus=" . s:status
            exe ":set foldcolumn=" . s:foldcolumn

            nnoremap j j
            nnoremap k k
            vnoremap j j
            vnoremap k k

            if exists('g:loaded_writegood')
                call writegood#disable()
            endif

            if (s:numbers == 0)
                set number
            endif
            if (s:relative == 0)
                set relativenumber
            endif
            if (s:cursor == 0)
                set cursorline
            endif
            let g:writer_on = 0
        endif
    else
        echo 'no gui, sorry'
    endif
endfunction

if !exists(":WriterToggle")
    command -nargs=0 WriterToggle :call s:Toggle()
endif

let &cpo = s:save_cpo
